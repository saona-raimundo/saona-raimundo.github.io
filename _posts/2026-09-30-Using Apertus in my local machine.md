---

layout: post
title:  "Using Open source AI in my local machine"
date:   2026-09-30 00:00:00 +0000
front:  true
# mastodon_id: 

---

[Open source AI](https://opensource.org/ai/open-source-ai-definition) is the gold standard for public AI thought as public good. [Apertus](https://www.apertus-ai.org/) is an open source AI developed by the Swiss AI Initiative. The question is: how does one use it in your own machine?

The LLM Apertus is published in [Swiss AI Initiative hugging face profile](https://huggingface.co/swiss-ai). Until today, its latest version is 1.5 and comes in two sizes (8B and 70B). 70B is hard to fit in consumer hardware (does not fit in mine), so we will go for [Apertus v1.5 8B](https://huggingface.co/swiss-ai/Apertus-v1.5-8B).

As it stands, the recommended setup to perform inference is using [vLLM](https://vllm.ai/). Unfortunately, vLLM is designed for large scale deployment, not single usage on a laptop, so it is not the best deployment tool for us. Instead, the best tool for personal local usage is [llama.cpp](https://llama-cpp.com/).

Moreover, Apertus v1.5 is multimodal, accepting text, audio, and visual input. For now, we simply want to chat with it, so text only. Therefore, we will use a stripped down version [Apertus v1.5 8B for text-only](https://huggingface.co/andreasmartin/apertus-v1.5-8b-text). Lastly, to perform inference with llama.cpp instead of vLLM, we need the model in the [GGUF format](https://en.wikipedia.org/wiki/GGUF) (instead of the published safetensors format). Therefore, we will use [andreasmartin/apertus-v1.5-8b-text-Q8_0-GGUF](https://huggingface.co/andreasmartin/apertus-v1.5-8b-text-Q8_0-GGUF).

Here is the simplest interface that works for me:

1. Download [apertus-v1.5-8b-text-q8_0.gguf](https://huggingface.co/andreasmartin/apertus-v1.5-8b-text-Q8_0-GGUF/blob/main/apertus-v1.5-8b-text-q8_0.gguf)
2. Install [llama.cpp](https://llama-cpp.com/). For example by running `brew install llama.cpp`.
3. Run a server performing inference on the model by running 
```
llama-server --alias apertus-1.5-8b --jinja --ctx-size 16384 --parallel 1 --threads 8 --threads-batch 16 --flash-attn on --cache-type-k q8_0 --cache-type-v q8_0 --cache-reuse 256 --temp 0.8 --top-p 0.9 --host 0.0.0.0 --port 8080 --model path/to/apertus-v1.5-8b-text-q8_0.gguf
```
This is using a few options explained below.

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

**Warning:** If, for some reason, your llama.cpp installation does not include an UI, then you have to do the following.

1. Run this to download the llama UI
```
mkdir path/to/llama-ui
curl -L https://huggingface.co/buckets/ggml-org/llama-ui/resolve/latest/dist.tar.gz | tar -xz -C path/to/llama-ui
```
2. Add `--path ~/.local/share/llama-ui` to the llama-server call
