function gifify -d "converts a movie to an animated gif"
    if [ -n $argv[1] ]
        ffmpeg -i $argv[1] -r 15 -f image2 out-static-%05d.png
        time convert -verbose -layers Optimize out-static*.png GIF:- | gifsicle --delay=0 --loop --careful --multifile - > $argv[1]".gif"
        rm out-static*.png
    end
end
