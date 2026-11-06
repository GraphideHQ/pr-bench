# pr-bench

A benchmark of test-fix pull requests and how automated code reviewers read them, kept by [Graphide](https://graphide.com).

Each folder under `cases/` is an unmodified copy of a permissively licensed open-source project at one commit, with that project's own licence file. Pull requests in this repository replay fixes for flaky or order-dependent tests that the projects' maintainers merged upstream, so we can see how code review bots and review agents judge them. All credit for the code goes to the upstream projects and the authors of those fixes. Nothing here is anyone's private code.

| Case | Upstream | Commit | Licence | Upstream fix |
|---|---|---|---|---|
| `cases/bquery-ui` | [bQuery/ui](https://github.com/bQuery/ui) | `e32e6589925f75ca94d233f1e6a069ac79fd62cb` | MIT | [bQuery/ui#29](https://github.com/bQuery/ui/pull/29) |
| `cases/mit-learn` | [mitodl/mit-learn](https://github.com/mitodl/mit-learn) | `bc99c8e88fe89d1749d2edc80cf17af1d6d76348` | BSD-3-Clause | [mitodl/mit-learn#4242](https://github.com/mitodl/mit-learn/pull/4242) |
| `cases/fugal-subnet` | [fugal-ai/fugal-subnet](https://github.com/fugal-ai/fugal-subnet) | `07c9c8148b6998bd7a8e8440170f1a1c57f6a00d` | MIT | [fugal-ai/fugal-subnet#171](https://github.com/fugal-ai/fugal-subnet/pull/171) |
| `cases/aiohttp-mcp` | [aio-libs/aiohttp-mcp](https://github.com/aio-libs/aiohttp-mcp) | `a049d4eaa730c56926df1f97344b0a755b58218c` | Apache-2.0 | [aio-libs/aiohttp-mcp#7](https://github.com/aio-libs/aiohttp-mcp/pull/7) |
| `cases/contr` | [contursofran/contr](https://github.com/contursofran/contr) | `7a9e7493b20423e2c7a94d41d2880775774ff33f` | Apache-2.0 | [contursofran/contr#377](https://github.com/contursofran/contr/pull/377) |

Each case's workflows, agent instruction files and configs sit inside its folder as upstream has them; GitHub runs only this repository's own `.github/workflows`.

`.bench/<case>/` holds how a fix is proved: `repro.sh` fails on the commit before the fix and passes with it, and `suite.sh` runs the tests the fix touches. The `proof` workflow runs both (`.bench/run.sh`) and writes a table to its summary.

The files outside `cases/` are Graphide's, under the MIT licence in `LICENSE`. Each folder under `cases/` stays under its own upstream licence.
