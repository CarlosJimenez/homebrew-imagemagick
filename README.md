# homebrew-imagemagick
Tap for imagemagick with pango

## Why this tap?
Due to restrictions in using options in latest versions of homebrew you cannot install imagemagick with pango option

* [Error when trying to use pango with imagemagick on OSX
](https://stackoverflow.com/questions/25838714/error-when-trying-to-use-pango-with-imagemagick-on-osx)

* You can verify support for pango with
  ```sh
  identify -list format | grep -Ei "Description|pango"
  ```

* To use this tap 
  ```sh
  brew install CarlosJimenez/homebrew-imagemagick/imagemagick-pango
  # In case you needed to move from imagemagick to imagemagick-pango
  brew link --overwrite imagemagick-pango
  ```
