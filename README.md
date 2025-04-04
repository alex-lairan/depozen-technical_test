# 🚀 Depozen – Test technique par Alexandre Lairan

Ce projet est le **test technique Depozen** réalisé par **Alexandre Lairan**.

---

## 🧰 Prérequis

- Ruby **3.4.1**
- Bundler
- PostgreSQL

---

## ⚙️ Installation

Installez les dépendances :

```bash
bundle install
```

---

## 🚀 Initialisation du projet

Ce projet utilise **plusieurs bases de données** (via ROM) et repose sur un script pour automatiser leur configuration.

Lancez simplement :

```bash
./script/init_project.sh
```

Ce script effectue les opérations suivantes :

1. 📋 Copie `.env.sample` vers `.env` si ce dernier n'existe pas
2. 🔐 Charge les variables d'environnement (`DATABASE_URL_1`, `DATABASE_URL_2`, etc.)
3. 💾 Exécute `rails db:setup` pour **chaque base** via la variable `DATABASE_URL`
4. ✅ Fournit une sortie claire pour suivre l’avancement

> ℹ️ L'utilisation de ce script est **fortement recommandée** pour éviter les erreurs manuelles, surtout avec la gestion multi-bases et ROM.

---

## 📡 Lancement de l'API

```bash
rails server
```

Accessible ensuite via [http://localhost:3000](http://localhost:3000)

---

## 📦 Structure de l’API

- Le projet ne possède **pas d’interface front-end**
- Il expose uniquement une API REST

| Prefix         | Verb | URI Pattern          | Controller#Action         |
|----------------|------|----------------------|----------------------------|
| rails_health_check | GET  | /up(.:format)         | rails/health#show         |
| users          | GET  | /users(.:format)       | users#index               |
| contracts      | GET  | /contracts(.:format)   | contracts#index           |
| my_contracts   | GET  | /my_contracts(.:format)| my_contracts#index        |

---

## ✅ Tests

Lancer les tests avec :

```bash
rails test
```
