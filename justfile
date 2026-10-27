set shell := ['nu', '-c']

# enter distrobox
enter:
    distrobox enter jekyll
# Jekyll watch
watch:
    distrobox enter jekyll -- bash -lc 'bundle exec jekyll serve --watch'
# (Re)Render a Quarto note as a blog post
note file:
    quarto render "{{file}}"
    open --raw "{{without_extension(file)}}.html" | str replace --regex '(?s)\A.*?<body[^>]*>' '' | str replace --regex '(?s)</body>\s*</html>\s*\z' "\n" | str replace "</p>" "</p>\n" | save --force "_posts/{{file_stem(file)}}.html"
    rm "{{without_extension(file)}}.html"
