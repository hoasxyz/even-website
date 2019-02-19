  This is the content of my website based on the theme [even](https://github.com/olOwOlo/hugo-theme-even).
  
- Running these code in RStudio to generate a livereload:

```r
options(blogdown.generator.server = TRUE)
blogdown::serve_site()
```
- Build command in [Netlify](https://app.netlify.com/account/sites) is:
  
```cmd
hugo --gc --enableGitInfo
```
- use shortcodes:

```markdown
{{% admonition warning warning %}}
biu biu biu.
{{% /admonition %}}
```