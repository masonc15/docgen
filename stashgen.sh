#!/usr/bin/bash

# require argument for package name
if [ -z "$1" ]; then
    echo "Usage: $0 <package name>"
    exit 1
fi

# take in argument for package name
pkgname=$1
DOCPATH=/home/colin/docs

# confirm that package directory exists in "/home/colin/.local/lib/python3.10/site-packages/"
if [ -d "/home/colin/.local/lib/python3.10/site-packages/$pkgname" ]; then
    echo "Package directory exists"
else
    echo "Package directory does not exist"
    exit 1
fi

pkg_path="/home/colin/.local/lib/python3.10/site-packages/$pkgname"

# get list of modules in package
modules=$(find $pkg_path -type f -name "*.py" | sed "s|$pkg_path/||" | sed "s|\.py$||" | sed "s|/|.|g")

echo "Modules:"
# print list of modules separated by newline
for module in $modules; do
    echo $module
done


# # for each module in modules, generate a markdown documentation file using pydoc-markdown and move to docs/$pkgname directory
# # example command: "pydoc-markdown -m stashapi.stashapp --render-toc > stashapp.md"



# create docs/$pkgname directory if it does not exist
if [ -d "$DOCPATH/$pkgname" ]; then
    echo "Documentation directory for $pkgname already exists"
else
    echo "Creating documentation directory for $pkgname"
    mkdir $DOCPATH/$pkgname
fi
 
for module in $modules; do
    echo "Generating documentation for $module"
    pydoc-markdown -m $pkgname.$module --render-toc > $DOCPATH/$pkgname/$module.md
done

echo "-------------------"
echo "Documentation generated for $pkgname in $DOCPATH/$pkgname"
