# TaskFlow

TaskFlow est une application Flutter Desktop de gestion de taches.  
Le projet a ete realise dans le cadre du rendu final Flutter Desktop.

L'objectif etait de construire une application organisee, persistante, testee, avec une navigation desktop et une architecture proche de l'architecture hexagonale.

## Fonctionnalites

- Gestion complete des taches : creation, affichage, modification et suppression.
- Gestion complete des projets : creation, affichage, modification et suppression.
- Association possible d'une tache a un projet.
- Priorites : basse, moyenne, haute, urgente.
- Statuts : a faire, en cours, terminee.
- Filtrage des taches :
  - toutes les taches,
  - taches d'aujourd'hui,
  - taches de la semaine.
- Recherche textuelle dans les taches.
- Theme clair / sombre persistant.
- Couleur d'accent personnalisable et persistante.
- Raccourcis clavier :
  - `Ctrl + N` : nouvelle tache,
  - `Ctrl + F` : afficher / masquer la recherche,
  - `Ctrl + D` : basculer le theme clair / sombre.
- Fenetre desktop configuree avec `window_manager` :
  - taille minimale `800x600`,
  - fenetre centree,
  - titre personnalise,
  - titre dynamique selon la section active.

## Architecture

Le projet est organise en plusieurs couches :

```text
lib/
+-- core/               # Theme et elements communs
+-- domain/             # Entites et interfaces de repositories
+-- application/        # Providers Riverpod et logique d'etat
+-- infrastructure/     # Implementations persistantes des repositories
+-- presentation/       # Pages, widgets et router
```

Cette organisation permet de separer les responsabilites :

- `domain` contient les modeles principaux (`Task`, `Project`) et les contrats (`TaskRepository`, `ProjectRepository`).
- `infrastructure` contient la maniere concrete de sauvegarder les donnees.
- `application` contient les providers Riverpod qui font le lien entre l'interface et les donnees.
- `presentation` contient l'affichage, les pages et les widgets.

## Choix techniques

### Freezed

Les entites `Task` et `Project` utilisent Freezed.

Cela permet d'avoir :

- des objets immuables,
- un `copyWith` genere automatiquement,
- la serialisation JSON avec `fromJson` et `toJson`.

Ce choix est utile pour modifier proprement une tache ou un projet sans changer directement l'objet original.

### Repository pattern

Les repositories sont definis dans le domaine avec des interfaces :

- `TaskRepository`
- `ProjectRepository`

Les implementations concretes sont dans `infrastructure`.

Cela permet de changer la maniere de stocker les donnees sans modifier le reste de l'application.

### SharedPreferences

Les taches, projets et preferences utilisateur sont sauvegardes avec `shared_preferences`.

Les donnees sont transformees en JSON grace aux methodes generees par Freezed.

Au premier lancement, l'application cree quelques donnees d'exemple. Des flags (`tasksSeeded` et `projectsSeeded`) evitent de recreer ces donnees plusieurs fois.

### Riverpod

Riverpod est utilise pour gerer l'etat de l'application :

- `TaskNotifier` pour les taches,
- `ProjectNotifier` pour les projets,
- providers de filtres pour aujourd'hui et la semaine,
- provider pour la recherche,
- provider pour le theme,
- provider pour la couleur d'accent.

Ce choix evite de gerer les donnees principales avec `setState` et rend l'etat plus clair.

### AutoRoute

La navigation utilise `auto_route` avec un layout principal et une sidebar permanente.

Les sections principales sont :

- Projets,
- Aujourd'hui,
- Cette semaine,
- Parametres.

### Material 3

Le theme est centralise dans `lib/core/theme/app_theme.dart`.

Il utilise :

- `useMaterial3: true`,
- `colorSchemeSeed`,
- `VisualDensity.adaptivePlatformDensity`.

Le but est d'avoir une configuration de theme propre et reutilisable.

### Window Manager

`window_manager` est utilise pour configurer la fenetre desktop :

- taille de depart,
- taille minimale,
- centrage,
- titre dynamique.

Le titre change selon la section active, par exemple :

```text
Projets - TaskFlow
Aujourd'hui - TaskFlow
Cette semaine - TaskFlow
Parametres - TaskFlow
```

## Tests

Le projet contient des tests avec `mockito`.

Deux tests principaux sont presents :

- un test verifiant le comportement d'un repository mocke,
- un test verifiant le fonctionnement du `TaskNotifier` avec `ProviderContainer` et des overrides Riverpod.

Commandes utiles :

```bash
flutter analyze
flutter test
```

## CI/CD

Un workflow GitHub Actions est present dans :

```text
.github/workflows/tests.yml
```

Il lance automatiquement :

```text
flutter pub get
dart run build_runner build
flutter analyze
flutter test
```

Cela permet de verifier automatiquement que le projet reste valide apres chaque push.

## Lancer le projet

Installer les dependances :

```bash
flutter pub get
```

Generer les fichiers necessaires :

```bash
dart run build_runner build
```

Lancer l'application Windows :

```bash
flutter run -d windows
```

Si Flutter demande le mode developpeur Windows, il faut l'activer avec :

```powershell
start ms-settings:developers
```

## Verification avant rendu

- L'application se lance.
- Les taches et projets persistent apres redemarrage.
- Le theme et la couleur d'accent persistent.
- Les raccourcis clavier fonctionnent.
- La fenetre respecte la taille minimale.
- `flutter analyze` passe.
- `flutter test` passe.
- Le workflow GitHub Actions passe au vert.
