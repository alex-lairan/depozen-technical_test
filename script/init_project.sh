#!/bin/bash
set -e

echo "🛠️  Initialisation du setup..."

# Copier .env si besoin
if [ ! -f .env ]; then
  if [ -f .env.sample ]; then
    echo "📋 Copie de .env.sample vers .env"
    cp .env.sample .env
  else
    echo "❌ Fichier .env.sample manquant !"
    exit 1
  fi
else
  echo "✅ .env déjà présent, pas de copie nécessaire"
fi

# Charger les variables
echo "📦 Chargement des variables d'environnement"
source .env

# Setup DB1
if [ -n "$DATABASE_URL_1" ]; then
  echo "💾 Setup base 1 via DATABASE_URL_1"
  DATABASE_URL="$DATABASE_URL_1" bundle exec rails db:setup
else
  echo "⚠️  DATABASE_URL_1 non défini, skipping..."
fi

# Setup DB2
if [ -n "$DATABASE_URL_2" ]; then
  echo "💾 Setup base 2 via DATABASE_URL_2"
  DATABASE_URL="$DATABASE_URL_2" bundle exec rails db:setup
else
  echo "⚠️  DATABASE_URL_2 non défini, skipping..."
fi

echo "✅ Setup terminé !"
