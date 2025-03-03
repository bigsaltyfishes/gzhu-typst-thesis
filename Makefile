TYPST_FLAGS += --root .

thesis:
	typst compile ${TYPST_FLAGS} thesis.typ thesis.pdf

watch:
	typst watch ${TYPST_FLAGS} thesis.typ thesis.pdf
