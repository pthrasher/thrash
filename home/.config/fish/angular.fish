function ngboot -d "Clone an angular playground and name it to your liking."
    if [ -z "$argv" ]
        echo "Clone boilerplate, and cd into dir."
        echo "usage: ngboot <project-name>"
    else
        git clone git@github.com:pthrasher/ng-boot.git $argv
        cd $argv
        sed -i \._ngboot 's/TITLETITLETITLE/test_sed/' index.html
        rm index.html._ngboot
        npm i
    end
end
