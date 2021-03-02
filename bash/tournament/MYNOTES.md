# My notes on the task

After seening glennj's and IsaacG's solutions I reworked mine.

## Testing

```shell
INPUT_FILE="test_input.txt"

cat <<INPUT >"$INPUT_FILE"
Courageous Californians;Devastating Donkeys;win
Allegoric Alaskans;Blithering Badgers;win
Devastating Donkeys;Allegoric Alaskans;loss
Courageous Californians;Blithering Badgers;win
Blithering Badgers;Devastating Donkeys;draw
Allegoric Alaskans;Courageous Californians;draw
INPUT

bash -x tournament.sh <<< "$(cat ${INPUT_FILE})"
```

## Used materials

- [Bash printf syntax basics](https://linuxconfig.org/bash-printf-syntax-basics-with-examples)

## Other good solutions

- [glennj's solution](https://exercism.io/tracks/bash/exercises/tournament/solutions/061eb7972a804170bca32e7e699822f4)
- [IsaacG's solution](https://exercism.io/tracks/bash/exercises/tournament/solutions/e3aa9a14bb0643538407c8c41c6e2bd0)
