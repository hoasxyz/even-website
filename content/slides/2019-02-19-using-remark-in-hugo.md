---
title: Using Remark in Hugo
author: Hoas
date: '2019-02-19'
slug: using-remark-in-hugo
---
class: center, middle
count: false
### 逃离office
--

count: false
 之
--

count: false
# Using Remark in Hugo

--

count: false
见：https://github.com/gnab/remark/wiki/Using-with-Hugo

---

# Formatting

Referring to https://github.com/gnab/remark/wiki/Formatting.

---

# Slide Separators

```md
---
```

## Incremental Slides

```c
- bullet 1
--

- bullet 2
```
- bullet 1
--

- bullet 2

---
## Incremental Slides
While expanding:

```md
- bullet 1
---

- bullet 1
- bullet 2
```

- bullet 1
---
## Incremental Slides
While expanding:

```md
- bullet 1
---

- bullet 1
- bullet 2
```

- bullet 1
- bullet 2
---
## Slide Notes

Some content.

???
Some note.

---
## Comments

```md
<!---
I'm a comment.
--->
```

<!---
I'm a comment.
--->

```md
[//]: # (I'm a comment)
```

[//]: # (I'm a comment)

---
name: agenda

## Agenda

```c
name: agenda
```
---
[The agenda](#agenda)

```c
[The agenda](#agenda)
```
---
count: false

# Agenda

--
1. Introduction

--
2. Markdown formatting

---
layout: true

# Section

---

## Sub section 1

```ruby
def add(a,b)
*  a + b
end

# Notice how there is no return statement.
```

---

## Sub section 2