# My notes on the task

Using docker image to test multiple bash versions - <https://hub.docker.com/_/bash>

Here's my investigation:

```shell
$ docker run -it --rm -v $(pwd)/:/word-count/ bash:4.1 \
  bash -c 'cd word-count && bash glennj_word_count.sh  "word"'
word: 1

$ docker run -it --rm -v $(pwd)/:/word-count/ bash:5.0 \
  bash -c 'cd word-count && bash glennj_word_count.sh  "word"'
word: 1

$ docker run -it --rm -v $(pwd)/:/word-count/ bash:5.1 \
  bash -c 'cd word-count && bash glennj_word_count.sh  "word"'
glennj_word_count.sh: line 45: ((: 'count[word]' += 1: syntax error: operand expected (error token is "'count[word]' += 1")
```

It appears that the problem is with bash 5.1. And the issue is
with line 45 of your solution (`glennj_word_count.sh`). If I just remove the single quotes `((count[$lc] += 1))` it works.
it works just fine. It appears that I am not the only one geting this error:
https://exercism.io/tracks/bash/exercises/word-count/solutions/9a87a6904e294f6a88d62c0a5e718348

I am not sure what changed exactly, but it appears that in 5.1 the `(('count[$lc]' += 1))` is not working.
