set -e # stop immediately if anything fails
stylus < stylus/alaska.stylus > static/css/alaska.css
saha compile
