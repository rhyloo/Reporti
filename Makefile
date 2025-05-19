TEX = xelatex --shell-scape
TARGET = main
BUILD_DIR = build

.PHONY: all clean view

all: $(TARGET).pdf

$(TARGET).pdf: $(TARGET).tex
	@mkdir -p $(BUILD_DIR)  
	$(TEX) -output-directory=$(BUILD_DIR) $<  
	$(TEX) -output-directory=$(BUILD_DIR) $<  
	@mv $(BUILD_DIR)/$(TARGET).pdf . 

clean:
	rm -rf $(BUILD_DIR)  
	rm -f *.aux *.log *.out *.toc *.bbl *.blg *.lof *.lot *.xwm

view: $(TARGET).pdf
	xdg-open $(TARGET).pdf 2>/dev/null || open $(TARGET).pdf 2>/dev/null

# Commit automático 
git-save:
	@echo "=== Guardando cambios en Git ==="
	git add .
	@if [ -n "$$(git status --porcelain)" ]; then \
		git commit -m "Update: $(shell date +'%Y-%m-%d %H:%M')"; \
	else \
		echo "No hay cambios"; \
	fi
	git pull origin main 
	git push origin main 

# Limpieza + Git
update: clean git-save
