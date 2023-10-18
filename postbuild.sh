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


if [ -z "$NEXT_PUBLIC_STATIC_VERSION" ]; then
    echo "POD_VERSION não está definida."
    exit 1
else
    mkdir $NEXT_PUBLIC_STATIC_VERSION
    mv .next $NEXT_PUBLIC_STATIC_VERSION/

    chmod -R 755 $NEXT_PUBLIC_STATIC_VERSION/.next

    ln -s $NEXT_PUBLIC_STATIC_VERSION/.next .next
    # Você pode usar $POD_VERSION em qualquer lugar do script agora
fi