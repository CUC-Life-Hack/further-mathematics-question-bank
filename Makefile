target?=
noAnswer?=false
verbose?=false

srcDir=src
outDir=build
tempOutDir=temp
envTex=$(srcDir)/environment.tex

compileTex=xelatex -synctex=1 -interaction=nonstopmode -file-line-error 
subMake=make \
	target?=$(target) noAnswer?=$(noAnswer) \
	--no-print-directory

entry:

build:
ifeq ($(target), )
	@echo No build target assigned;
else
	@ \
	baseDir=$$("pwd"); \
	echo 'Building $(target)...'; \
	echo '' > $(envTex); \
	echo '\def\noAnswer{$(noAnswer)}' >> $(envTex); \
	cd $(srcDir)/content; \
	mkdir -p $(tempOutDir); \
	compileOutput=$$($(compileTex) -output-directory=$(tempOutDir) $(target).tex); \
	if [[ $$compileOutput != *!* ]]; then \
		for pdf in $(tempOutDir)/*.pdf; do \
			mv $$pdf $$baseDir/$(outDir); \
		done; \
	else \
		if [[ $(verbose) != true ]]; then \
			while IFS= read -r line; do \
				if [[ "$$line" == !* ]]; then \
					echo "$$line"; \
				fi; \
			done <<< "$$compileOutput"; \
		fi; \
	fi; \
	if [[ $(verbose) == true ]]; \
		then echo "$$compileOutput"; \
	fi; \
	# rm -rf $(tempOutDir); \
	
endif

all:
	@echo 'Building all contents...';
	@for file in $(srcDir)/content/*.tex; do \
		base="$$(basename $$file)"; \
		$(subMake) target="$${base%.*}" build; \
	done;

clean:
	rm -rf $(outDir);

remove-aux:
	@for file in $(outDir)/*.*; do \
		if [[ "$$file" =~ \.(aux|log|synctex.gz)$$ ]]; then \
			rm $$file; \
		fi \
	done;

.PHONY: build
