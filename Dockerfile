# 1. Partir d'une image qui contient déjà Python 3.14
FROM python:3.14-slim

# 2. Dossier de travail dans le conteneur
WORKDIR /app

# 3. Installer les bibliothèques (mêmes versions que sur mon ordinateur)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copier le notebook et les autres fichiers du projet
COPY . .

# 5. Télécharger le jeu de données dès maintenant :
#    ainsi le notebook marche même sans Internet
RUN python -c "from sklearn.datasets import fetch_20newsgroups; fetch_20newsgroups(subset='all', remove=('headers', 'footers', 'quotes'), categories=['alt.atheism', 'talk.religion.misc', 'comp.graphics', 'sci.space'])"

# 6. Ouvrir Jupyter Notebook sur le port 8888
EXPOSE 8888
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--ServerApp.token="]
