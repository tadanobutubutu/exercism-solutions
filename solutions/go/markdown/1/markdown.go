package markdown

import (
	"regexp"
	"strings"
)

var inlineMarkup = regexp.MustCompile(`__(.+?)__|_(.+?)_`)

// Render converts the supported Markdown blocks and inline emphasis to HTML.
func Render(markdown string) string {
	var output strings.Builder
	var paragraph strings.Builder
	var items []string

	flushParagraph := func() {
		if paragraph.Len() == 0 {
			return
		}
		output.WriteString("<p>")
		output.WriteString(renderInline(paragraph.String()))
		output.WriteString("</p>")
		paragraph.Reset()
	}
	flushList := func() {
		if len(items) == 0 {
			return
		}
		output.WriteString("<ul>")
		for _, item := range items {
			output.WriteString("<li>")
			output.WriteString(renderInline(item))
			output.WriteString("</li>")
		}
		output.WriteString("</ul>")
		items = nil
	}

	for _, line := range strings.Split(markdown, "\n") {
		if level, body, ok := heading(line); ok {
			flushParagraph()
			flushList()
			output.WriteString("<h")
			output.WriteByte(byte('0' + level))
			output.WriteString(">")
			output.WriteString(renderInline(body))
			output.WriteString("</h")
			output.WriteByte(byte('0' + level))
			output.WriteString(">")
			continue
		}

		if strings.HasPrefix(line, "* ") {
			flushParagraph()
			items = append(items, line[2:])
			continue
		}

		flushList()
		if line == "" {
			flushParagraph()
			continue
		}
		paragraph.WriteString(line)
	}

	flushParagraph()
	flushList()
	if output.Len() == 0 {
		return "<p></p>"
	}
	return output.String()
}

func heading(line string) (int, string, bool) {
	level := 0
	for level < len(line) && line[level] == '#' {
		level++
	}
	if level < 1 || level > 6 || level >= len(line) || line[level] != ' ' {
		return 0, "", false
	}
	return level, line[level+1:], true
}

func renderInline(text string) string {
	return inlineMarkup.ReplaceAllStringFunc(text, func(markup string) string {
		if strings.HasPrefix(markup, "__") {
			return "<strong>" + markup[2:len(markup)-2] + "</strong>"
		}
		return "<em>" + markup[1:len(markup)-1] + "</em>"
	})
}
