#!/bin/bash

rm -rf _book
gitbook build .

for html in `find _book | grep \.html`; do

    dirs=$((`echo $html | tr '/' '\n' | wc -l` - 2))
    path="./"
    for((i=0; i < $dirs; i++)); do
        path="${path}../"
    done

    sed -i 's,https://github.com/ioctf/round-1/issues,mailto:support@forallsecure.com,g' $html
    sed -i 's,https://github.com/ioctf/round-1/edit/master/[^\"]*,https://ioctf.com,g' $html
    sed -i 's,Edit and Contribute,Play Online,g' $html

    sed -i 's,https://github.com/ioctf/round-1,http://forallsecure.com,g' $html
    sed -i 's,https://github.com/ioctf,http://forallsecure.com,g' $html

    favico=`grep 'shortcut icon' $html | cut -f 4 -d \"`
    sed -i "s,<head>,<head><link rel=\"icon\" type=\"image/ico\" href="$favico">,g" $html

    cp images/ForAllSecure_Simple_Logo_Black.ico _book/gitbook/images/favicon.ico

    line=`grep "e summary" $html`
    grep -v "e summary" $html > /tmp/tmp
    sed -i "s,><i class=\"fa fa-bookmark-o\"></i></a>,style=\"background-image: url('${path}images/ForAllSecure_Simple_Logo_Black_200x200.png'); background-size: 80%; background-position: center center; background-repeat: no-repeat\"><i style="visibility:hidden" class=\"fa fa-bookmark-o\"></i></a>\n$line,g" /tmp/tmp
    cp /tmp/tmp $html


    grep -v facebook $html | grep -v google-plus | grep -v twitt | grep -v watchers | grep -v stargazer | grep -v "Generated using" > /tmp/tmp
    mv /tmp/tmp $html

done

sed -i 's/e\.getJSON(i\.basePath+\"\/search_index\.json\")\.then(u)/u(ioctf_special)/g' _book/gitbook/app.js

echo -n "var ioctf_special = JSON.parse(" > /tmp/app.js
python -c "import json; print repr(json.dumps(json.load(open('_book/search_index.json'))))" >> /tmp/app.js
echo ");" >> /tmp/app.js

cat _book/gitbook/app.js >> /tmp/app.js
cp /tmp/app.js _book/gitbook/app.js

sed -i 's,githubId\&\&(l,githubId\&\&(true,g' _book/gitbook/app.js

rm _book/package.sh
