DATA_DIR=data
SCRIPTS_DIR=scripts
MODELS_DIR=models
RESULTS_DIR=results

.PHONY: all data train evaluate deploy

data:
	python3 scripts/data_prep.py

train: data
	python3 scripts/train_model.py

evaluate: train
	python3 scripts/evaluate_model.py

deploy: train
	python3 scripts/deploy_model.py

# Nama virtual environment
VENV ?= venv

# Target untuk membuat virtual environment jika belum ada
new: dependencies.txt
	@echo "Membuat virtual environment..."
	python3 -m venv $(VENV)
	@echo "Aktivasi virtual environment..."
	$(VENV)/Scripts/activate
	@echo "Menginstall dependencies..."
	pip3 install -r dependencies.txt
	
# Target untuk export dependencies
export: 
	$(VENV)/Scripts/activate
	@echo "Export dependencies..."
	pip3 freeze > dependencies.txt

# Target untuk mengaktifkan virtual environment
activate: $(VENV)/Scripts/activate.bat
	$(VENV)/Scripts/activate
	@echo "Virtual environment diaktifkan. Gunakan 'source $(VENV)/Scripts/activate' untuk aktivasi manual."

# Target untuk menghapus virtual environment
clean:
	rm -rf $(VENV)
	@echo "Virtual environment telah dihapus."
