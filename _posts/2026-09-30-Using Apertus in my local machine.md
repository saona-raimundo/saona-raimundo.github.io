---

layout: post
title:  "Using Open source AI in my local machine"
date:   2026-09-30 00:00:00 +0000
front:  true
# mastodon_id: 

---

[Open source AI](https://opensource.org/ai/open-source-ai-definition) is the gold standard for public AI thought as a public good. [Apertus](https://www.apertus-ai.org/) is an open source AI developed by the Swiss AI Initiative. The question is: how do you use it in your own machine?

The LLM Apertus is published in [Swiss AI Initiative hugging face profile](https://huggingface.co/swiss-ai). As of today, its latest version is 1.5 and comes in two sizes (8B and 70B). 70B is hard to fit in consumer hardware (does not fit in mine), so we will go for [Apertus v1.5 8B](https://huggingface.co/swiss-ai/Apertus-v1.5-8B).

As it stands, the recommended setup to perform inference is using [vLLM](https://vllm.ai/). Unfortunately, vLLM is designed for large scale deployment, not single usage on a laptop, so it is not the best deployment tool for us. Instead, the best tool for personal local usage is [llama.cpp](https://llama.app/).

Moreover, Apertus v1.5 is multimodal, accepting text, audio, and visual input. For now, we simply want to chat with it, so text only. Therefore, we will use a stripped down version [Apertus v1.5 8B for text-only](https://huggingface.co/andreasmartin/apertus-v1.5-8b-text). Lastly, to perform inference with llama.cpp instead of vLLM, we need the model in the [GGUF format](https://en.wikipedia.org/wiki/GGUF) (instead of the published safetensors format). Therefore, we will use [andreasmartin/apertus-v1.5-8b-text-Q8_0-GGUF](https://huggingface.co/andreasmartin/apertus-v1.5-8b-text-Q8_0-GGUF).

Here is the simplest interface that works for me:

1. Download [apertus-v1.5-8b-text-q8_0.gguf](https://huggingface.co/andreasmartin/apertus-v1.5-8b-text-Q8_0-GGUF/blob/main/apertus-v1.5-8b-text-q8_0.gguf)
2. Install [llama.cpp](https://llama-cpp.com/). For example by running `brew install llama.cpp`.
3. Run a server performing inference on the model by running 
```
llama-server --alias apertus-1.5-8b --jinja --ctx-size 16384 --parallel 1 --threads 8 --threads-batch 16 --flash-attn on --cache-type-k q8_0 --cache-type-v q8_0 --cache-reuse 256 --temp 0.8 --top-p 0.9 --host 0.0.0.0 --port 8080 --reasoning off --model path/to/apertus-v1.5-8b-text-q8_0.gguf
```
If you are willing to go a bit further, there are some improvements you can do to this setup. For now, this uses the following options.

| Option | What it does | Default | Your value |
|---|---|---|---|
| `--model` | Path to the GGUF file | none (required) | the Apertus Q8_0 file |
| `--alias` | Model name shown in the UI and returned by `/v1/models` | derived from the model path | `apertus-1.5-8b` |
| `--jinja` | Formats chat messages with the Jinja chat template embedded in the GGUF | on in recent builds, off in older ones | on (safe to keep either way) |
| `--ctx-size` | Context window in tokens; sets how much KV-cache memory is reserved | older builds: 4096; newer builds: 0, meaning the model's full training context (262K here) | 16384 |
| `--parallel` | Number of simultaneous request slots, which share the context | auto (−1) in recent builds, often 4; 1 in older builds | 1, so one conversation gets all 16K |
| `--threads` | CPU threads for token generation | auto, roughly the physical core count | 8 |
| `--threads-batch` | CPU threads for prompt processing | same as `--threads` | 16 |
| `--flash-attn` | Flash attention: faster, uses less memory, and is required for a quantized V cache | `auto` | `on` |
| `--cache-type-k` | Precision of the K half of the KV cache | `f16` | `q8_0` (half the memory) |
| `--cache-type-v` | Precision of the V half of the KV cache | `f16` | `q8_0` |
| `--cache-reuse` | Minimum matching chunk size (in tokens) for reusing cached prompt parts via KV shifting; speeds up edits and regenerations | 0 (off) | 256 |
| `--temp` | Sampling temperature | 0.8 | 0.8 (already the default) |
| `--top-p` | Nucleus sampling cutoff | 0.95 | 0.9 (Swiss AI's recommendation) |
| `--host` | Address the server listens on | `127.0.0.1` (localhost only) | `0.0.0.0` (all interfaces, needed for Tailscale) |
| `--port` | HTTP port | 8080 | 8080 (already the default) |
| `--reasoning` | Thinking mode | auto | on |

**Warning:** If, for some reason, your llama.cpp installation does not include a UI, then you have to do the following.

1. Run this to download the llama UI
```
mkdir path/to/llama-ui
curl -L https://huggingface.co/buckets/ggml-org/llama-ui/resolve/latest/dist.tar.gz | tar -xz -C path/to/llama-ui
```
2. Add `--path path/to/llama-ui` to the llama-server call


## Custom chat template

To get the best experience, you will need to change the "chat template". Until now, we have used the original chat template from Swiss AI, which describes a multimodal model, and is tested on a different inference engine, not llama.cpp. Therefore, there are a few errors that can be easily avoided.

### Errors considered

**Default system prompt**

- Describes a multimodal model. But this deployment handles text only.

**Reasoning (thinking) is part of the response**

- Reasoning appears together with the response.
- Past reasoning becomes part of the chat history.

**Cache does not handle reasoning correctly**

- Reasoning is not saved for caching by default.
- But now that reasoning is part of the response, the cache will miss on the latest reasoning step

### Proposal

**Default system prompt**

> You are Apertus 1.5, an assistant developed by the Swiss AI Initiative, extended from Apertus 1 via continued pretraining. In this deployment you handle text only.

**Reasoning display and cache friendly**

By adding a few lines to the chat template, the reasoning is displayed correctly, and taken into account for the cache.
To dissable including the reasoning on the cache, add `--no-reasoning-preserve` on the command.

Now, the command to start the server is the following.
```
llama-server --alias apertus-1.5-8b --jinja --ctx-size 16384 --parallel 1 --threads 8 --threads-batch 16 --flash-attn on --cache-type-k q8_0 --cache-type-v q8_0 --cache-reuse 256 --temp 0.8 --top-p 0.9 --host 0.0.0.0 --port 8080 --reasoning on --model path/to/apertus-v1.5-8b-text-q8_0.gguf --path path/to/llama-ui --chat-template-file path/to/apertus-v1.5-8b-text-q8_0-chat_template.jinja
```

Below is the final chat_template. I use it as the file `apertus-v1.5-8b-text-q8_0-chat_template.jinja`.
```jinja
{%- macro render_typescript_type(param_spec, required_params, is_nullable=false) -%}
    {%- if param_spec.type == "array" -%}
        {%- if param_spec['items'] -%}
            {%- if param_spec['items']['type'] == "string" -%}
                {{- "string[]" }}
            {%- elif param_spec['items']['type'] == "number" -%}
                {{- "number[]" }}
            {%- elif param_spec['items']['type'] == "integer" -%}
                {{- "number[]" }}
            {%- elif param_spec['items']['type'] == "boolean" -%}
                {{- "boolean[]" }}
            {%- else -%}
                {%- set inner_type = render_typescript_type(param_spec['items'], required_params) -%}
                {%- if inner_type == "object | object" or inner_type|length > 50 -%}
                    {{- "any[]" }}
                {%- else -%}
                    {{- inner_type + "[]" }}
                {%- endif -%}
            {%- endif -%}
            {%- if param_spec.nullable -%}
                {{- " | null" }}
            {%- endif -%}
        {%- else -%}
            {{- "any[]" }}
            {%- if param_spec.nullable -%}
                {{- " | null" }}
            {%- endif -%}
        {%- endif -%}
    {%- elif param_spec.type is defined and param_spec.type is iterable and param_spec.type is not string and param_spec.type is not mapping and param_spec.type[0] is defined -%}
        {#- Handle array of types like ["object", "object"] from Union[dict, list] #}
        {%- if param_spec.type | length > 1 -%}
            {{- param_spec.type | join(" | ") }}
        {%- else -%}
            {{- param_spec.type[0] }}
        {%- endif -%}
    {%- elif param_spec.oneOf -%}
        {#- Handle oneOf schemas - check for complex unions and fallback to any #}
        {%- set has_object_variants = false -%}
        {%- for variant in param_spec.oneOf -%}
            {%- if variant.type == "object" -%}
                {%- set has_object_variants = true -%}
            {%- endif -%}
        {%- endfor -%}
        {%- if has_object_variants and param_spec.oneOf|length > 1 -%}
            {{- "any" }}
        {%- else -%}
            {%- for variant in param_spec.oneOf -%}
                {{- render_typescript_type(variant, required_params) -}}
                {%- if variant.description %}
                    {{- "// " + variant.description }}
                {%- endif -%}
                {%- if variant.default is defined %}
                    {{ "// default: " + variant.default|tojson }}
                {%- endif -%}
                {%- if not loop.last %}
                    {{- " | " }}
                {% endif -%}
            {%- endfor -%}
        {%- endif -%}
    {%- elif param_spec.type == "string" -%}
        {%- if param_spec.enum -%}
            {{- '"' + param_spec.enum|join('" | "') + '"' -}}
        {%- else -%}
            {{- "string" }}
            {%- if param_spec.nullable %}
                {{- " | null" }}
            {%- endif -%}
        {%- endif -%}
    {%- elif param_spec.type == "number" -%}
        {{- "number" }}
    {%- elif param_spec.type == "integer" -%}
        {{- "number" }}
    {%- elif param_spec.type == "boolean" -%}
        {{- "boolean" }}
    {%- elif param_spec.type == "object" -%}
        {%- if param_spec.properties -%}
            {{- "{\n" }}
            {%- for prop_name, prop_spec in param_spec.properties.items() -%}
                {{- prop_name -}}
                {%- if prop_name not in (param_spec.required or []) -%}
                    {{- "?" }}
                {%- endif -%}
                {{- ": " }}
                {{ render_typescript_type(prop_spec, param_spec.required or []) }}
                {%- if not loop.last -%}
                    {{-", " }}
                {%- endif -%}
            {%- endfor -%}
            {{- "}" }}
        {%- else -%}
            {{- "object" }}
        {%- endif -%}
    {%- else -%}
        {{- "any" }}
    {%- endif -%}
{%- endmacro -%}

{%- macro render_tools(tools) -%}
    {%- for tool in tools %}
        {%- if tool.function %}
            {%- set tool = tool.function %}
        {%- endif %}
        {{- "// " + tool.description + "\n" }}
        {{- "type "+ tool.name + " = " }}
        {%- if tool.parameters and tool.parameters.properties %}
            {{- "(_: {\n" }}
            {%- for param_name, param_spec in tool.parameters.properties.items() %}
                {%- if param_spec.description %}
                    {{- "// " + param_spec.description + "\n" }}
                {%- endif %}
                {{- param_name }}
                {%- if param_name not in (tool.parameters.required or []) -%}
                    {{- "?" }}
                {%- endif -%}
                {{- ": " }}
                {{- render_typescript_type(param_spec, tool.parameters.required or []) }}
                {%- if param_spec.default is defined -%}
                    {%- if param_spec.enum %}
                        {{- ", // default: " + param_spec.default }}
                    {%- elif param_spec.oneOf %}
                        {{- "// default: " + param_spec.default }}
                    {%- else %}
                        {{- ", // default: " + param_spec.default|tojson }}
                    {%- endif -%}
                {%- endif -%}
                {%- if not loop.last %}
                    {{- ",\n" }}
                {%- else %}
                    {{- "\n" }}
                {%- endif -%}
            {%- endfor %}
            {{- "}) => any;" }}
        {%- else -%}
            {{- "() => any;" }}
        {%- endif -%}
        {%- if not loop.last -%}
            {{- "\n" }}
        {%- endif -%}
    {%- endfor %}
{%- endmacro -%}

{{ bos_token }}

{%- set system_token = '<|system_start|>' -%}
{%- set end_system_token = '<|system_end|>' -%}
{%- set developer_token = '<|developer_start|>' -%}
{%- set end_developer_token = '<|developer_end|>' -%}
{%- set user_token = '<|user_start|>' -%}
{%- set end_user_token = '<|user_end|>' -%}
{%- set assistant_token = '<|assistant_start|>' -%}
{%- set end_assistant_token = '<|assistant_end|>' -%}
{%- set inner_token = '<|inner_prefix|>' -%}
{%- set outer_token = '<|inner_suffix|>' -%}
{%- set tool_calls_token = '<|tools_prefix|>' -%}
{%- set end_tool_calls_token = '<|tools_suffix|>' -%}
{%- set tool_output_start_token = '<|tool_output_start|>' -%}
{%- set tool_output_end_token = '<|tool_output_end|>' -%}
{%- set image_token = '<|image|>' -%}
{%- set audio_token = '<|audio|>' -%}

{%- set ns = namespace(in_assistant=false, in_tool=false, in_inner=false, waiting_for_tool_outputs=false, assistant_format=none) -%}

{%- if messages and messages[0].role == 'system' -%}
    {%- if "content" in messages[0] -%}
        {%- if messages[0].content is string -%}
            {{ system_token + messages[0].content + end_system_token }}
        {%- elif messages[0].content is mapping and "text" in messages[0].content -%}
            {{ system_token + messages[0].content.text + end_system_token }}
        {%- else -%}
            {{- raise_exception("Invalid system message") -}}
        {%- endif -%}
    {%- else -%}
        {{- raise_exception("Invalid system message") -}}
    {%- endif -%}
    {%- set loop_messages = messages[1:] -%}
{%- else -%}
    {{ system_token + 'You are Apertus 1.5, an assistant developed by the Swiss AI Initiative, extended from Apertus 1 via continued pretraining. In this deployment you handle text only.' + end_system_token }}
    {%- set loop_messages = messages -%}
{%- endif -%}

{{ developer_token + 'Deliberation: ' }}
{%- if enable_thinking is defined and enable_thinking -%}
    {{ 'enabled\n' }}
{%- else -%}
    {{ 'disabled\n' }}
{%- endif -%}
{%- if tools is defined and tools -%}
    {{ 'Tool Capabilities:\n' + render_tools(tools) }}
{%- else -%}
    {{ 'Tool Capabilities: disabled' }}
{%- endif -%}
{{ end_developer_token }}

{%- for message in loop_messages -%}
    {%- if message.role == 'user' -%}
        {%- set ns.in_inner = false -%}
        {%- if ns.in_tool -%}
            {{ tool_output_end_token }}
            {%- set ns.in_tool = false -%}
        {%- endif -%}
        {%- if ns.in_assistant -%}
            {{ end_assistant_token }}
            {%- set ns.in_assistant = false -%}
        {%- endif -%}
        {%- if "content" in message -%}
            {{ user_token }}
            {%- if message.content is string -%}
                {{ message.content }}
            {%- elif message.content is mapping and "parts" in message.content -%}
                {%- set parts = message.content.parts -%}
                {%- for part in parts -%}
                    {%- if part.type == "text" -%}
                        {{ part.text }}
                    {%- elif part.type == "image" or part.type == "image_url" or part.type == "input_image" -%}
                        {{ image_token }}
                    {%- elif part.type == "audio" or part.type == "audio_url" or part.type == "input_audio" -%}
                        {{ audio_token }}
                    {%- else -%}
                        {{- raise_exception("Invalid user part: " + part.type) -}}
                    {%- endif -%}
                {%- endfor -%}
            {%- elif message.content is not string and message.content is not mapping and message.content is iterable -%}
                {%- for part in message.content -%}
                    {%- if part.type == "text" -%}
                        {{ part.text }}
                    {%- elif part.type == "image" or part.type == "image_url" or part.type == "input_image" -%}
                        {{ image_token }}
                    {%- elif part.type == "audio" or part.type == "audio_url" or part.type == "input_audio" -%}
                        {{ audio_token }}
                    {%- else -%}
                        {{- raise_exception("Invalid user part: " + part.type) -}}
                    {%- endif -%}
                {%- endfor -%}
            {%- else -%}
                {{- raise_exception("Invalid user message: " + message.role) -}}
            {%- endif -%}
            {{ end_user_token }}
        {%- endif -%}
    {%- elif message.role == 'assistant' -%}
        {%- if not ns.in_assistant -%}
            {{ assistant_token }}
            {%- set ns.in_assistant = true -%}
        {%- endif -%}
        {%- if "content" in message -%}
            {%- if (message.content is string or message.content is none) and (ns.assistant_format is none or ns.assistant_format == "string") -%}
                {%- if ns.in_tool -%}
                    {{ tool_output_end_token }}
                    {%- set ns.in_tool = false -%}
                {%- endif -%}
                {%- set ns.assistant_format = "string" -%}
                {%- if message.reasoning_content is string and message.reasoning_content -%}
                    {{ inner_token + message.reasoning_content + outer_token }}
                {%- endif -%}
                {{ message.content or "" }}
            {%- elif message.content is mapping and "blocks" in message.content and (ns.assistant_format is none or ns.assistant_format == "mapping") -%}
                {%- set ns.assistant_format = "mapping" -%}
                {%- set blocks = message.content.blocks -%}
                {%- for block in blocks -%}
                    {%- if block.type == 'thoughts' -%}
                        {%- if ns.in_tool -%}
                            {{ tool_output_end_token }}
                            {%- set ns.in_tool = false -%}
                        {%- endif -%}
                        {%- if not ns.in_inner -%}
                            {%- set ns.in_inner = true -%}
                            {{ inner_token }}
                        {%- endif -%}
                        {{ block.text }}
                    {%- elif block.type == 'tool_calls' -%}
                        {%- if ns.in_tool -%}
                            {{ tool_output_end_token }}
                            {%- set ns.in_tool = false -%}
                        {%- endif -%}
                        {%- if ns.in_inner and not loop.first and block.calls|length == 1 and block.calls[0].name == 'display_answers' -%}
                            {%- set ns.in_inner = false -%}
                            {{ outer_token }}
                        {%- endif -%}
                        {{ tool_calls_token + '[' }}
                        {%- for tool_call in block.calls -%}
                            {%- if tool_call.function %}
                                {%- set tool_call = tool_call.function %}
                            {%- endif %}
                            {{- '{"' + tool_call.name + '": ' + (tool_call.arguments if tool_call.arguments is string else tool_call.arguments | tojson) + '}' }}
                            {%- if not loop.last -%}
                                {{- ", " }}
                            {%- endif -%}
                        {%- endfor -%}
                        {{ ']' + end_tool_calls_token }}
                        {%- set ns.waiting_for_tool_outputs = true -%}
                    {%- elif block.type == 'tool_outputs' -%}
                        {%- if ns.in_tool -%}
                            {{- raise_exception("Cannot have both tool outputs as separate messages and tool outputs as blocks") -}}
                        {%- endif -%}
                        {{ tool_output_start_token }}
                        {%- for tool_output in block.outputs -%}
                            {{- tool_output.output }}
                            {%- if not loop.last -%}
                                {{- ", " }}
                            {%- endif -%}
                        {%- endfor -%}
                        {{- tool_output_end_token }}
                        {%- set ns.waiting_for_tool_outputs = false -%}
                    {%- elif block.type == 'response' -%}
                        {%- if ns.in_tool -%}
                            {{ tool_output_end_token }}
                            {%- set ns.in_tool = false -%}
                        {%- endif -%}
                        {%- if (not loop.first and ns.in_inner) or (ns.in_assistant and ns.in_inner) -%}
                            {%- set ns.in_inner = false -%}
                            {{ outer_token }}
                        {%- endif -%}
                        {{ block.text }}
                    {%- else -%}
                        {{- raise_exception("Invalid assistant block type: " + block.type) -}}
                    {%- endif -%}
                {%- endfor -%}
            {%- else -%}
                {{- raise_exception("Invalid assistant content") -}}
            {%- endif -%}
        {%- else -%}
            {{- raise_exception("Invalid assistant message") -}}
        {%- endif -%}
        {%- if "tool_calls" in message and message.tool_calls -%}
            {{ tool_calls_token + '[' }}
            {%- for tool_call in message.tool_calls -%}
                {%- if tool_call.type is defined and tool_call.type != 'function' -%}
                    {{- raise_exception("Invalid tool call type: " + tool_call.type) -}}
                {%- endif -%}
                {%- if tool_call.function %}
                    {%- set tool_call = tool_call.function %}
                {%- endif %}
                {%- if tool_call.name and tool_call.arguments is defined -%}
                    {{- '{"' + tool_call.name + '": ' + (tool_call.arguments if tool_call.arguments is string else tool_call.arguments | tojson) + '}' }}
                    {%- if not loop.last -%}
                        {{- ", " }}
                    {%- endif -%}
                {%- else -%}
                    {{- raise_exception("Invalid tool call") -}}
                {%- endif -%}
            {%- endfor -%}
            {{ ']' + end_tool_calls_token }}
            {%- set ns.waiting_for_tool_outputs = true -%}
        {%- endif -%}
    {%- elif message.role == 'tool' -%}
        {%- if not ns.in_assistant -%}
            {{- raise_exception("Tool message outside of assistant") -}}
        {%- endif -%}
        {%- if not ns.in_tool -%}
            {{ tool_output_start_token }}
            {%- set ns.in_tool = true -%}
        {%- else -%}
            {{ ", "}}
        {%- endif -%}
        {{ message.content }}
        {%- set ns.waiting_for_tool_outputs = false -%}
    {%- else -%}
        {{- raise_exception("Invalid message role") -}}
    {%- endif -%}
{%- endfor -%}
{%- if ns.in_tool -%}
    {{ tool_output_end_token }}
{%- endif -%}
{%- if ns.in_assistant and not (continue_assistant_message is defined and continue_assistant_message) and not ns.waiting_for_tool_outputs -%}
    {{ end_assistant_token }}
{%- endif -%}
{%- if add_generation_prompt -%}
    {{ assistant_token }}
{%- endif -%}
```