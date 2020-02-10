  This is the content of my website based on the theme [even](https://github.com/olOwOlo/hugo-theme-even).

[![Netlify Status](https://api.netlify.com/api/v1/badges/e6cb33cf-2ac7-4b29-bed3-1157ac4fd0ed/deploy-status)](https://app.netlify.com/sites/hoas/deploys)

- Running these code in RStudio to generate a livereload:

```r
options(blogdown.generator.server = TRUE)
blogdown::serve_site()
```
- Build command in [Netlify](https://app.netlify.com/account/sites) is:
  
```cmd
hugo --gc --enableGitInfo
```
- Use shortcodes:

```markdown
{{% admonition warning warning %}}
biu biu biu.
{{% /admonition %}}
```

- Inquiring the version of R package:

```r
packageVersion("snow")
```

- Add Algolia search after committing one post:

```go
$ hugo-algolia -s
```

