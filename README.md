# Yiotta

![enter image description here](https://i.ibb.co/y4RzB5R/Capture-d-e-cran-2024-09-26-a-11-40-30.png)

Éditée par l'association [fable-Lab](https://www.fable-lab.com/association/), [Yiotta](https://yiotta.fable-lab.org) est une base de données sous licence libre qui recense des illustrations, des traductions, des histoires, des enregistrements audio afin de faciliter la transmission et la médiation linguistiques dans une dizaine de langues.

## Prérequis

**PostgreSQL** : Vous devez avoir PostgreSQL installé. Pour l'installer, suivez les instructions sur le [site officiel de PostgreSQL](https://www.postgresql.org/download/).
    
**Meilisearch** : Vous devez avoir Meilisearch installé. Vous pouvez trouver les instructions d'installation sur le [site officiel de Meilisearch](https://www.meilisearch.com/docs/learn/self_hosted/install_meilisearch_locally).
    
**Overmind** : Pour faciliter l'expérience de développement, vous pouvez installer Overmind, qui gère les processus du serveur de développement avec le fichier `Procfile.dev`. Pour l'installer, suivez les instructions sur le [dépôt GitHub d'Overmind](https://github.com/DarthSim/overmind).    

## Installation

**Clonez le dépôt** :   
 ```bash
git clone https://github.com/FableLab/Yiotta
cd Yiotta
```
    
**Installez les dépendances** :
```bash
bundle install
``` 
    
**Configurez la base de données** :
```bash
rails db:create
rails db:migrate
``` 
 
**Démarrez le serveur en mode développement** :   
```bash
overmind start
```
    
**Adresse** :

Accédez à `http://localhost:3000` (ou le port configuré) pour accéder à l'application.
   

## Financeur

Ce projet est soutenu par le Ministère de la Culture en 2022.

<img src="https://yiotta.fable-lab.org/assets/soutien_ministere_culture-ca2d888e04d1c5db55e1a91df5b94ddd61d8b0de4e7f7fd834be4dc73ff34b7f.png" alt="Logo du Ministère de la Culture" width="90"/>

## Licence

Ce projet est sous la **GNU Affero General Public License (AGPL)**.

### Résumé de la licence AGPL

La GNU Affero General Public License (AGPL) est une licence de logiciel libre qui garantit à tous les utilisateurs la liberté d'utiliser, de modifier et de redistribuer le logiciel tout en préservant ces libertés pour les versions dérivées. En outre, si le logiciel est utilisé sur un serveur, le code source doit être accessible aux utilisateurs qui interagissent avec le service.

### Principales caractéristiques :

-   **Liberté d'utilisation :** Utilisez le logiciel pour n'importe quel usage.
-   **Liberté de modification :** Modifiez le logiciel pour l'adapter à vos besoins.
-   **Partage dans les mêmes conditions :** Toute redistribution doit être faite sous la même licence AGPL.
-   **Accès au code source :** Si le logiciel est utilisé sur un serveur, le code source doit être mis à disposition des utilisateurs.

### Pour plus d'informations :

Pour plus de détails, consultez le texte complet de la licence : [GNU Affero General Public License](https://www.gnu.org/licenses/agpl-3.0.html).
