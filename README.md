# Election Présidentielle pour FiveM (ESX)

Ce script permet d’organiser une élection présidentielle immersive sur un serveur FiveM ESX, avec :

- Blip à la mairie pour accéder au menu des élections.
- Inscription en tant que candidat via le menu en jeu.
- Vote pour un candidat via le menu en jeu.
- Commandes admin pour démarrer et arrêter l’élection.
- Notifications automatiques pour les joueurs.

---

## Dépendances

- [ESX Legacy](https://github.com/esx-framework/esx-legacy) (ou ESX v1 final)
- [esx_menu_default](https://github.com/esx-framework/esx_menu_default)
- [es_extended] (pour le getSharedObject)
- Un point de mairie sur la map (modifiable dans le script)

---

## Installation

1. **Placez** le dossier `election` dans `resources/` ou `resources/[local]/` de votre serveur.
2. **Ajoutez** dans votre `server.cfg` :
   ```
   ensure election
   ```
3. **Vérifiez** que vos dépendances ESX et esx_menu_default sont installées et fonctionnelles.

---

## Utilisation

### Commandes Admin

- `/startelection`  
  Démarre une nouvelle élection présidentielle (seul un admin peut le faire).

- `/endelection`  
  Termine l’élection, annonce le gagnant, remet à zéro les votes et candidats.

### Joueurs

1. **Rendez-vous à la Mairie** (blip vert sur la map, coordonnées modifiables dans le script).
2. **Appuyez sur la touche E** pour ouvrir le menu.
3. **Choisissez** :
   - S’enregistrer comme candidat (si vous souhaitez vous présenter).
   - Voter (si vous souhaitez voter pour un candidat).
4. **Notifications** et résultats affichés automatiquement.

---

## Personnalisation

- **Coordonnées de la mairie** :  
  Modifiez la variable `mairiePos` dans `client.lua` pour déplacer le blip/menu.

- **Nom du blip** :  
  Changez la ligne `AddTextComponentString("Élections Présidentielles")` si besoin.

---

## Limitations & Conseils

- Les inscrits comme candidats sont identifiés par leur nom Steam/ESX.
- Un joueur ne peut voter qu’une seule fois par élection.
- Le script ne gère pas de permissions avancées : adaptez les commandes à votre système d’admin si besoin.
- Testez bien les notifications et menus sur votre serveur pour vérifier la compatibilité avec votre version d’ESX.

---

## Support

Pour toute question ou suggestion, ouvrez une issue ou contactez-moi sur Discord : **ZynixDevelopment**

---
