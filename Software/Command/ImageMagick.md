Diff of two image
=====
* Export to png
```sh
convert image2.png image1.png -alpha off +repage \( -clone 0 -clone 1 -compose difference -composite -threshold 0 \) -delete 1 -alpha off -compose copy_opacity -composite -trim diff.png
```
* Export to pdf
```sh
convert image2.png image1.png -alpha off +repage \( -clone 0 -clone 1 -compose difference -composite -threshold 0 \) -delete 1 -alpha off -compose copy_opacity -composite -trim diff.pdf
```
