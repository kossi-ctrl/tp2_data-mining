# TP2 Data Mining : Clustering de documents texte

Ce TP compare plusieurs méthodes de **clustering** (regroupement automatique) pour classer des documents texte **sans connaître leur catégorie à l'avance**, puis vérifie si les groupes trouvés correspondent aux vraies catégories.

## 📂 Données

Le jeu de données **20 Newsgroups** (fourni par scikit-learn), limité à **4 catégories** :

| Catégorie | Sujet |
|---|---|
| `alt.atheism` | athéisme |
| `comp.graphics` | informatique / graphisme |
| `sci.space` | espace |
| `talk.religion.misc` | religion |

Au total : **3 387 documents**. Les en-têtes, signatures et citations des messages sont retirés pour ne garder que le texte.

## ⚙️ Méthode

1. **Vectorisation TF-IDF** : chaque document devient un vecteur de nombres (7 929 mots retenus, mots vides anglais retirés).
2. **Réduction de dimension (LSA)** : `TruncatedSVD` à 100 composantes + normalisation.
3. **Clustering** avec 4 groupes :
   - **K-means** sur les vecteurs TF-IDF ;
   - **K-means** sur les vecteurs LSA ;
   - **Clustering hiérarchique (Ward)** sur les vecteurs LSA.
4. **Évaluation** avec 5 mesures : homogénéité, complétude, V-measure, Adjusted Rand Index, coefficient de silhouette.
5. **Visualisation** des groupes en 2D avec une ACP (PCA).

## 📊 Résultats

| Méthode | Homogénéité | Complétude | V-measure | ARI | Silhouette | Temps |
|---|---|---|---|---|---|---|
| K-means (TF-IDF) | 0,349 | 0,398 | 0,372 | 0,203 | 0,007 | 0,11 s |
| Hiérarchique Ward (LSA) | 0,299 | 0,369 | 0,330 | 0,249 | 0,021 | 0,68 s |

**Ce qu'on retient :**
- Les scores sont **modestes** pour toutes les méthodes (sous 0,40).
- **K-means** est plus rapide et un peu meilleur sur la plupart des mesures, mais il **dépend du hasard** : un essai a même placé presque tous les documents dans un seul groupe.
- **Le clustering hiérarchique** est plus lent, mais **stable** (toujours le même résultat), et son découpage est le plus proche des vraies catégories.
- Toutes les méthodes retrouvent bien **le graphisme** et **l'espace**, mais **aucune ne sépare l'athéisme et la religion**, car ces textes utilisent le même vocabulaire.

## ▶️ Lancer le notebook (avec Python)

Testé avec **Python 3.14**.

```bash
git clone https://github.com/kossi-ctrl/tp2_data-mining.git
cd tp2_data-mining
pip install -r requirements.txt
jupyter notebook
```

Ouvrir `tp2_data-mining.ipynb`, puis lancer toutes les cellules dans l'ordre (*Kernel → Restart & Run All*). Le jeu de données est téléchargé automatiquement au premier lancement (connexion Internet nécessaire).

## 🐳 Lancer avec Docker (sans installer Python)

Il suffit d'avoir **Docker** installé.

```bash
git clone https://github.com/kossi-ctrl/tp2_data-mining.git
cd tp2_data-mining
docker build -t tp2-data-mining .
docker run -p 8888:8888 tp2-data-mining
```

Puis ouvrir **http://localhost:8888** dans le navigateur. Le jeu de données est déjà inclus dans l'image : pas besoin d'Internet pour lancer le notebook.

Si le port 8888 est déjà utilisé, remplacer le premier `8888` par un autre numéro (par exemple `-p 9999:8888`) et ouvrir **http://localhost:9999**.

## 📁 Contenu du dépôt

```
.
├── tp2_data-mining.ipynb   # le notebook (code, figures et commentaires)
├── requirements.txt        # les bibliothèques et leurs versions
├── Dockerfile              # la recette de l'image Docker
├── .dockerignore           # les fichiers exclus de l'image
└── README.md               # ce fichier
```

## 👥 Auteurs

- **Kossi Zangbe**
- **Kokou Dokanu**

Master Humanités Numériques, Ingénierie des Données · Université de Tours (CESR)
