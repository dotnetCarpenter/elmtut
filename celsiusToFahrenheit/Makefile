js = main.js
min := $(patsubst %.js,%.min.js, $(js))
html = index.html
optimizedHtml = index2.html
templateHtml = ../template.html
source = src/Main.elm

pure_funcs = 'pure_funcs="F2,F3,F4,F5,F6,F7,F8,F9,A2,A3,A4,A5,A6,A7,A8,A9",pure_getters,keep_fargs=false,unsafe_comps,unsafe'

all: $(html) $(min) $(optimizedHtml)
.phony: debug

# put whatever you're curious about below..
debug:
	@echo $(min)


$(optimizedHtml): $(templateHtml)
	@cp -v $(templateHtml) $(optimizedHtml)


$(min): $(js)
	@yarn terser $< --compress $(pure_funcs) --mangle --output=$@


$(html) $(js): $(source)
	elm make $(source);
	elm make --optimize --output $(js) $(source);
