#!/bin/sh

OUT_DIR=dist/
OUT_JS=$OUT_DIR/main.js
OUT_ZIP=out.zip

echo 'Building...'

# Clean up
rm -rf $OUT_DIR
rm -f $OUT_ZIP

mkdir $OUT_DIR

# Build the JS file
touch $OUT_JS
for file in \
    globals.js \
    util/first-item.js \
    util/resizer.js \
    util/math.js \
    engine/entity.js \
    engine/sprite.js \
    engine/world.js \
    entities/camera.js \
    entities/character.js \
    entities/player.js \
    entities/enemy.js \
    entities/structure.js \
    entities/floor.js \
    entities/bullet.js \
    entities/particle.js \
    weapon/weapon.js \
    weapon/pistol.js \
    weapon/machine-gun.js \
    weapon/shotgun.js \
    graphics/wrap.js \
    graphics/create-canvas.js \
    graphics/font.js \
    input/keyboard.js \
    input/mouse.js \
    map-generator.js \
    game.js \
    index.js \
; do
    cat src/$file >> $OUT_JS
done

# Terser
# tmp=`mktemp`
# npx -y terser $OUT_JS --compress ecma=2015,computed_props=false 1>$tmp
# cat $tmp 1>$OUT_JS
# rm $tmp

# Roadroller
# npx -y roadroller $OUT_JS  -o $OUT_JS

# Copy files as is
for file in \
    style.css \
    index.html \
; do
    cp src/$file $OUT_DIR/$file
done

echo "Done"

# Zip file
(cd dist && zip -q -r - .) > $OUT_ZIP
du -h $OUT_ZIP

exit 0
