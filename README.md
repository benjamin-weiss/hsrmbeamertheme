HRI Beamer Theme
================

A nice looking Beamer theme, based on HSRM Beamer theme by
[Benjamin Weiss](mailto:Benjamin.Weiss@kreatiefton.de), with a
few improvements like full-screen pictures and videos. [Download the
pre-compiled demo presentation](https://github.com/severin-lemaignan/hri-beamer-theme/blob/master/presentation.pdf?raw=true).

![Title page](doc/ex1.jpg)
![TikZ figure](doc/ex3.jpg)


To compile, simply run `make`. This Beamer theme requires `lualatex` for
compilation (available in the `TeXlive` distribution for example).

It also looks nicer if the Flama font is installed in your system. Download it from here: 
- [Flama Light](http://fontpark.net/en/font/flamalight)
- [Flama Book](http://fontpark.net/en/font/flamabook)
- [Flama Medium](http://fontpark.net/en/font/flamamedium)

Special commands in this theme
------------------------------

### Full-screen pictures

![Full page picture, with optional caption](doc/ex2.jpg)

```latex
\imageframe[caption]{mypic.jpg}
```

- `caption`: optional caption (can be any Latex code) that will be displayed as
  an overlay on top of the picture

### Videos

```latex
\video[aspect ratio]{width}{myvideo.webm}
```

This integrates a video in your presentation (attention: the video file
*itself* is not embedded in the PDF: you need to take it along with your PDF).
Clicking on it opens the default system video player for the given video format
(using `pdfpc`, you can also play the video directly inside your presentation,
cf below).

- `aspect ratio` is a real value equal to height/width, defaults to 16:9 (ie,
  0.56).
- `width` is any valid Beamer length (like `0.7\textwidth` for instance)

A preview picture (typically, the first frame of the video) is used if a file
called `myvideo_thumb.jpg` is found. Assuming `avconv` is available on your
system, `make thumbs` will generate such a preview picture for you.

Note that, if played with [pdfpc](https://github.com/severin-lemaignan/pdfpc),
the video will be nicely overlaid on top of the slide, exactly covering the
video preview. `pdfpc` also support special extended URI for the video file,
allowing to define options like start and stop times (in seconds from the
beginning), looping, auto-start and mute (no audio). For instance:

```latex
\video[aspect ratio]{width}{myvideo.webm?start=20&stop=34&autostart&noaudio&loop}
```

`make thumbs` will also use the start time, if specified, to generate a
thumbnail of the video at the correct time.


You can also produce a full-screen video frame with:

```latex
\videoframe[aspect ratio]{myvideo.webm}
```

`aspect ratio` defaults to 4:3 (ie, fullscreen on Beamer). Set it to 0.56
(=9/16) for 16:9 for instance.

### Bibliography references

You can insert references to specific paper in the footer of a slide that way:

```latex
{
  \paper{Superman, How Kripton changed my life, Springer 2014}
  \begin{frame}
  ...
  \end{frame}
}
```


Reference and License
---------------------

Based on HSRM Beamer theme by [Benjamin.Weiss@kreatiefton.de](mailto:Benjamin.Weiss@kreatiefton.de)

Made available under the [GNU Public License](http://www.gnu.org/licenses/gpl-3.0.en.html).

