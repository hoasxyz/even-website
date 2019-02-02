{{ .RawContent }}

{{ with .OutputFormats.Get "markdown" -}}
<a href="{{ .Permalink }}">查看本文 Markdown 版本 »</a>
{{- end }}