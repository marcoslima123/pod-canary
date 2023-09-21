# #!/bin/bash

# VERSION="1.0.0"
# NEXT_BUILD_DIR="./.next"
# VERSIONED_DIR="$NEXT_BUILD_DIR/$VERSION/static"

# # Mover os arquivos estáticos para o diretório versionado
# mkdir -p $VERSIONED_DIR
# mv $NEXT_BUILD_DIR/static/* $VERSIONED_DIR

# # Remover a pasta static
# rm -r $NEXT_BUILD_DIR/static/

# # Procura e substitui caminhos em arquivos gerados
# find $NEXT_BUILD_DIR -type f -exec sed -i -e "s|/_next/static/|/_next/$VERSION/static/|g" -e "s|static/css/|$VERSION/static/css/|g" -e "s|static/chucks/|/$VERSION/static/chucks|g" -e "s|static/chucks/pages|/$VERSION/static/chucks/pages|g" {} \;

mkdir 2.0.0
mv .next 2.0.0/

chmod -R 755 2.0.0/.next

ln -s 2.0.0/.next .next