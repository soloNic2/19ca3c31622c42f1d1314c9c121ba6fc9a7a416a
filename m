Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14868C7EE22
	for <git@archiver.kernel.org>; Wed, 10 May 2023 01:56:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjEJB45 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 21:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjEJB4z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 21:56:55 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B0FE74
        for <git@vger.kernel.org>; Tue,  9 May 2023 18:56:51 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so6009071a12.1
        for <git@vger.kernel.org>; Tue, 09 May 2023 18:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683683810; x=1686275810;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=X1y5AAwmDpp7Do7l+AqOaSxJi5CUtQj/3G7HFhgdLFo=;
        b=qTSI++LJKr+tjXrGChRCrwvlHMlJH/jONKC+8RjYIn84oDFQX80xTT5y73Y+CppEuC
         WYzFwluM2IyZKSXrnXAidWJUNgJ8IOEj9ckgoPQrvwWOSb0M5Y4Za0WM3kB4pGFoISjb
         ZMvX8226sOBfAVKd4X9PeZ5Mt1oh5fPXLw+y5QpouVPLqDhycnSWb9ZVoMyXGhmyCiAB
         LJffOadbmUN7hJePw98ugCr0MeU5TvCZBxKIAOSackjlJzFAYsR35k6ZfCvTRWp+V3Dw
         VUrlpyONb/r5MfYmufieJhJqvrR5CMPn36BQyT/Mq7TLmNxWXJXEyMtaWo5SG3OMcErc
         3rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683683810; x=1686275810;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :subject:to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1y5AAwmDpp7Do7l+AqOaSxJi5CUtQj/3G7HFhgdLFo=;
        b=FAc8dO8HnwwAwz3RLl0f3Snz+vFOsTrvZacdJEE10PoJ0f3U29dqAF06zGCrZs9QZI
         IW4A5lTNzaCyAiCHywbgoOMA0pdT91cTObkqNr5nGiwE8PP/+VwdRsn76urIZFL7/cHJ
         6LMPloVKZcUbNArYZQO/StG7MfQNX2kkmT+O8N8FyMtG/Veq+Qo4nmci7OmlA3dmacAa
         r+eBaFJ+TNaZDLE7Y5af1bV+Bf63GpXU2Ro3KffhIsPAX78g3/J0FqOTcjMPQtEFdGqr
         ZpWK1YZmAvMazlfzsEh8gF07IUVDFq1dX/6N1jgmj4104R4WmfMzYXNKMNHQNboHzSP1
         sFvA==
X-Gm-Message-State: AC+VfDzDuqL146vrkdNGglExC/FAVZ/ixydCbIDmy8yGLnzNYOZqYuVn
        7GgnBA5IzpefOWiAD73tNyb/DKhFBNM=
X-Google-Smtp-Source: ACHHUZ6neP010uLXWrfip6BJN8ztSV6/t+A4qeKOLcKIPs3RDxnj8mZ79j1XFooQYK5kBAzLtiMGJQ==
X-Received: by 2002:a17:90a:9605:b0:250:9e7b:2798 with SMTP id v5-20020a17090a960500b002509e7b2798mr6403119pjo.18.1683683809696;
        Tue, 09 May 2023 18:56:49 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id a1-20020a17090acb8100b0024e2980574asm12503266pju.4.2023.05.09.18.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 18:56:49 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2023, #03; Tue, 9)
X-master-at: 5597cfdf47db94825213fefe78c4485e6a5702d8
X-next-at: 74a8c732097c5a952ed7b01bc0ef452daf5b8643
Date:   Tue, 09 May 2023 18:56:48 -0700
Message-ID: <xmqqmt2d0x0f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a future
release).  Commits prefixed with '-' are only in 'seen', and aren't
considered "accepted" at all and may be annotated with an URL to a
message that raises issues but they are no means exhaustive.  A
topic without enough support may be discarded after a long period of
no activity.

We are getting closer to pre-release freeze.  As I prefer to have
any non-trivial topics cook for 7 calendar days in 'next', anything
not in 'next' by Friday this week are unlikely to be in -rc1 for the
next release.

Copies of the source code to Git live in many repositories, and the
following is a list of the ones I push into or their mirrors.  Some
repositories have only a subset of branches.

With maint, master, next, seen, todo:

	git://git.kernel.org/pub/scm/git/git.git/
	git://repo.or.cz/alt-git.git/
	https://kernel.googlesource.com/pub/scm/git/git/
	https://github.com/git/git/
	https://gitlab.com/git-vcs/git/

With all the integration branches and topics broken out:

	https://github.com/gitster/git/

Even though the preformatted documentation in HTML and man format
are not sources, they are published in these repositories for
convenience (replace "htmldocs" with "manpages" for the manual
pages):

	git://git.kernel.org/pub/scm/git/git-htmldocs.git/
	https://github.com/gitster/git-htmldocs.git/

Release tarballs are available at:

	https://www.kernel.org/pub/software/scm/git/

--------------------------------------------------
[Graduated to 'master']

* en/header-split-cache-h-part-2 (2023-04-24) 22 commits
  (merged to 'next' on 2023-05-01 at 722c412915)
 + reftable: ensure git-compat-util.h is the first (indirect) include
 + diff.h: reduce unnecessary includes
 + object-store.h: reduce unnecessary includes
 + commit.h: reduce unnecessary includes
 + fsmonitor: reduce includes of cache.h
 + cache.h: remove unnecessary headers
 + treewide: remove cache.h inclusion due to previous changes
 + cache,tree: move basic name compare functions from read-cache to tree
 + cache,tree: move cmp_cache_name_compare from tree.[ch] to read-cache.c
 + hash-ll.h: split out of hash.h to remove dependency on repository.h
 + tree-diff.c: move S_DIFFTREE_IFXMIN_NEQ define from cache.h
 + dir.h: move DTYPE defines from cache.h
 + versioncmp.h: move declarations for versioncmp.c functions from cache.h
 + ws.h: move declarations for ws.c functions from cache.h
 + match-trees.h: move declarations for match-trees.c functions from cache.h
 + pkt-line.h: move declarations for pkt-line.c functions from cache.h
 + base85.h: move declarations for base85.c functions from cache.h
 + copy.h: move declarations for copy.c functions from cache.h
 + server-info.h: move declarations for server-info.c functions from cache.h
 + packfile.h: move pack_window and pack_entry from cache.h
 + symlinks.h: move declarations for symlinks.c functions from cache.h
 + treewide: be explicit about dependence on strbuf.h
 (this branch is used by en/header-split-cache-h-part-3.)

 More header clean-up.
 source: <pull.1517.v2.git.1682194649.gitgitgadget@gmail.com>


* jk/parse-commit-with-malformed-ident (2023-04-27) 4 commits
  (merged to 'next' on 2023-04-28 at cb6ea0412a)
 + parse_commit(): describe more date-parsing failure modes
 + parse_commit(): handle broken whitespace-only timestamp
 + parse_commit(): parse timestamp from end of line
 + t4212: avoid putting git on left-hand side of pipe

 The commit object parser has been taught to be a bit more lenient
 to parse timestamps on the author/committer line with a malformed
 author/committer ident.
 source: <20230427081330.GA1461786@coredump.intra.peff.net>


* jw/send-email-update-gmail-insn (2023-04-28) 1 commit
  (merged to 'next' on 2023-05-01 at cb5d83ee92)
 + send-email docs: Remove mention of discontinued gmail feature

 Doc update to drop use of deprecated app-specific password against
 gmail.
 source: <20221001104609.18453-1-j.witteveen@gmail.com>


* mh/fix-detect-compilers-with-nondigit-versions (2023-04-26) 1 commit
  (merged to 'next' on 2023-04-28 at c0c54291c2)
 + Handle some compiler versions containing a dash

 The detect-compilers script to help auto-tweaking the build system
 had trouble working with compilers whose version number has extra
 suffixes.  The script has been taught that certain suffixes (like
 "-win32" in "gcc 10-win32") can be safely stripped as they share
 the same features and bugs with the version without the suffix.
 source: <20230426004843.3391826-1-mh@glandium.org>


* ob/messages-capitalize-exception (2023-04-28) 1 commit
  (merged to 'next' on 2023-05-01 at db0ef42b3a)
 + messages: capitalization and punctuation exceptions
 (this branch uses ob/sequencer-i18n-fix.)

 Message update.
 source: <20230428125649.1719796-1-oswald.buddenhagen@gmx.de>


* ob/sequencer-i18n-fix (2023-04-28) 1 commit
  (merged to 'next' on 2023-05-01 at 242ca8ce15)
 + sequencer: actually translate report in do_exec()
 (this branch is used by ob/messages-capitalize-exception.)

 Message update.
 source: <20230428125649.1719796-2-oswald.buddenhagen@gmx.de>


* ob/t3501-retitle (2023-05-01) 1 commit
  (merged to 'next' on 2023-05-01 at 52730fcaaa)
 + t/t3501-revert-cherry-pick.sh: clarify scope of the file

 Retitle a test script with an overly narrow name.
 source: <20230430100034.1889796-1-oswald.buddenhagen@gmx.de>

--------------------------------------------------
[New Topics]

* jc/t9800-fix-use-of-show-s-raw (2023-05-06) 1 commit
  (merged to 'next' on 2023-05-09 at f4d7a7d671)
 + t9800: correct misuse of 'show -s --raw' in a test

 A test fix.

 Will merge to 'master'.
 source: <xmqqild5rvvw.fsf@gitster.g>


* tl/push-branches-is-an-alias-for-all (2023-05-06) 1 commit
  (merged to 'next' on 2023-05-09 at 1d8c3e5dcf)
 + push: introduce '--branches' option

 "git push --all" gained an alias "git push --branches".

 Will merge to 'master'.
 source: <20230506113408.61529-2-tenglong.tl@alibaba-inc.com>


* en/header-split-cache-h-part-3 (2023-05-08) 25 commits
 - fsmonitor-ll.h: split this header out of fsmonitor.h
 - hash-ll, hashmap: move oidhash() to hash-ll
 - git-compat-util.h: remove unneccessary include of wildmatch.h
 - builtin.h: remove unneccessary includes
 - list-objects-filter-options.h: remove unneccessary include
 - diff.h: remove unnecessary include of oidset.h
 - repository: remove unnecessary include of path.h
 - log-tree: replace include of revision.h with simple forward declaration
 - cache.h: remove this no-longer-used header
 - read-cache*.h: move declarations for read-cache.c functions from cache.h
 - repository.h: move declaration of the_index from cache.h
 - merge.h: move declarations for merge.c from cache.h
 - diff.h: move declaration for global in diff.c from cache.h
 - preload-index.h: move declarations for preload-index.c from elsewhere
 - sparse-index.h: move declarations for sparse-index.c from cache.h
 - name-hash.h: move declarations for name-hash.c from cache.h
 - run-command.h: move declarations for run-command.c from cache.h
 - statinfo: move stat_{data,validity} functions from cache/read-cache
 - read-cache: move shared add/checkout/commit code
 - add: modify add_files_to_cache() to avoid globals
 - read-cache: move shared commit and ls-files code
 - setup: adopt shared init-db & clone code
 - init-db, clone: change unnecessary global into passed parameter
 - init-db: remove unnecessary global variable & document existing bug
 - Merge branch 'en/header-split-cache-h-part-2' into en/header-split-cache-h-part-3

 source: <pull.1525.git.1683431149.gitgitgadget@gmail.com>


* js/subtree-fully-spelt-quiet-and-debug-options (2023-05-08) 1 commit
 - subtree: support long global flags

 "git subtree" (in contrib/) update.

 Will merge to 'next'.
 source: <pull.1514.git.1683428988693.gitgitgadget@gmail.com>


* js/gitk-fixes-from-gfw (2023-05-08) 3 commits
  (merged to 'next' on 2023-05-08 at adb334deec)
 + Merge gitk changes into js/gitk-fixes-from-gfw
 + gitk: escape file paths before piping to git log
 + gitk: prevent overly long command lines

 Gitk updates from GfW project.

 Will merge to 'master'.
 source: <pull.1469.git.1674559397.gitgitgadget@gmail.com>


* la/doc-interpret-trailers (2023-05-08) 11 commits
 - doc: trailer: add more examples in DESCRIPTION
 - doc: trailer: mention 'key' in DESCRIPTION
 - doc: trailer.<token>.command: emphasize deprecation
 - doc: trailer.<token>.command: refer to existing example
 - doc: trailer: trailer.<token>.cmd: add missing verb phrase
 - doc: trailer: use angle brackets for <token> and <value>
 - doc: trailer: explain "commit mesage part" on first usage
 - doc: trailer: remove redundant phrasing
 - doc: trailer: --no-divider: more precise language
 - doc: trailer: swap verb order
 - doc: trailer: fix grammar

 Doc update.

 Needs review.
 source: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>


* ar/test-cleanup-unused-file-creation (2023-05-09) 1 commit
  (merged to 'next' on 2023-05-09 at 7734f3d690)
 + test: rev-parse-upstream: add missing cmp

 Test fix.

 Will merge to 'master'.
 source: <20230509000246.1760327-1-felipe.contreras@gmail.com>


* cc/git-replay (2023-05-09) 16 commits
 - SQUASH???
 - replay: stop assuming replayed branches do not diverge
 - replay: add --contained to rebase contained branches
 - replay: add --advance or 'cherry-pick' mode
 - replay: disallow revision specific options and pathspecs
 - replay: use standard revision ranges
 - replay: make it a minimal server side command
 - replay: remove HEAD related sanity check
 - replay: remove progress and info output
 - replay: add an important FIXME comment about gpg signing
 - replay: don't simplify history
 - replay: introduce pick_regular_commit()
 - replay: die() instead of failing assert()
 - replay: start using parse_options API
 - replay: introduce new builtin
 - t6429: remove switching aspects of fast-rebase

 source: <20230509175347.1714141-1-christian.couder@gmail.com>


* jc/pack-ref-exclude-include (2023-05-09) 3 commits
 - pack-refs: teach pack-refs --include option
 - pack-refs: teach --exclude option to exclude refs from being packed
 - docs: clarify git-pack-refs --all will pack all refs

 "git pack-refs" learns "--include" and "--exclude" to tweak the ref
 hierarchy to be packed using pattern matching.
 source: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>


* jk/test-verbose-no-more (2023-05-08) 3 commits
  (merged to 'next' on 2023-05-09 at 897bfd0a6b)
 + t: drop "verbose" helper function
 + t7001: use "ls-files --format" instead of "cut"
 + t7001: avoid git on upstream of pipe

 Retire "verbose" helper function from the test framework.

 Will merge to 'master'.
 source: <20230508185953.GA2108869@coredump.intra.peff.net>

--------------------------------------------------
[Stalled]

* ed/fsmonitor-windows-named-pipe (2023-03-24) 1 commit
 - fsmonitor: handle differences between Windows named pipe functions

 Fix fsmonitor on Windows when the filesystem path contains certain
 characters.

 Expecting a reroll.
 cf. <b9cf67e4-22a7-2ff0-8310-9223bea10d6d@jeffhostetler.com>
 source: <pull.1503.git.1679678090412.gitgitgadget@gmail.com>


* rn/sparse-diff-index (2023-04-10) 1 commit
 - diff-index: enable sparse index

 "git diff-index" command has been taught to work better with the
 sparse index.

 Expecting a reroll.
 cf. <62821012-4fc3-5ad8-695c-70f7ab14a8c9@github.com>
 source: <20230408112342.404318-1-nanth.raghul@gmail.com>


* ja/worktree-orphan (2023-04-17) 8 commits
 - worktree add: emit warn when there is a bad HEAD
 - worktree add: extend DWIM to infer --orphan
 - worktree add: introduce "try --orphan" hint
 - worktree add: add --orphan flag
 - t2400: add tests to verify --quiet
 - t2400: refactor "worktree add" opt exclusion tests
 - t2400: print captured git output when finished
 - worktree add: include -B in usage docs

 'git worktree add' learned how to create a worktree based on an
 orphaned branch with `--orphan`.

 Expecting a reroll.
 cf. <m7crhly2j3k76whydbtdwhvzghvoql436g3lqtst4v3ahv75aa@wq5zjepgrxz5>
 source: <20230417093255.31079-1-jacobabel@nullpo.dev>


* es/recurse-submodules-option-is-a-bool (2023-04-10) 1 commit
 - usage: clarify --recurse-submodules as a boolean

 The "--[no-]recurse-submodules" option of "git checkout" and others
 supported an undocumented syntax --recurse-submodules=<value> where
 the value can spell a Boolean in various ways.  The support for the
 syntax is being dropped.

 Expecting a reroll.
 cf. <ZDSTFwMFO7vbj/du@google.com>
 source: <ZDSTFwMFO7vbj/du@google.com>


* tb/pack-bitmap-index-seek (2023-03-20) 6 commits
 - pack-bitmap.c: factor out `bitmap_index_seek_commit()`
 - pack-bitmap.c: use `bitmap_index_seek()` where possible
 - pack-bitmap.c: factor out manual `map_pos` manipulation
 - pack-bitmap.c: drop unnecessary 'inline's
 - pack-bitmap.c: hide bitmap internals in `read_be32()`
 - pack-bitmap.c: hide bitmap internals in `read_u8()`

 Clean-up the pack-bitmap codepath.

 Kicked back to 'seen' out of 'next'.
 There is a BUG() on data errors that needs to be fixed.
 source: <cover.1679342296.git.me@ttaylorr.com>


* cb/checkout-same-branch-twice (2023-03-22) 2 commits
 - SQUASH??? the test marked to expect failure passes from day one
 - checkout/switch: disallow checking out same branch in multiple worktrees

 "git checkout -B $branch" failed to protect against checking out
 a branch that is checked out elsewhere, unlike "git branch -f" did.

 Expecting a hopefully minor and final reroll.
 cf. <CAPUEspj_Bh+LgYLnWfeBdcq_uV5Cbou-7H51GLFjzSa5Qzby9w@mail.gmail.com>
 source: <20230120113553.24655-1-carenas@gmail.com>


* tk/pull-conflict-suggest-rebase-merge-not-rebase-true (2023-02-13) 1 commit
 - pull: conflict hint pull.rebase suggestion should offer "merges" vs "true"

 In an advice message after failed non-ff pull, we used to suggest
 setting pull.rebase=true, but these days pull.rebase=merges may be
 more inline with the original spirit of "rebuild your side on top
 of theirs".

 May want to discard.
 This is too much of a departure from the existing practice.
 cf. <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 cf. <CABPp-BGqAxKnxDRVN4cYMteLp33hvto07R3=TJBT5WubJT4+Og@mail.gmail.com>
 source: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>


* ab/tag-object-type-errors (2022-11-22) 5 commits
 - tag: don't emit potentially incorrect "object is a X, not a Y"
 - tag: don't misreport type of tagged objects in errors
 - object tests: add test for unexpected objects in tags
 - object-file.c: free the "t.tag" in check_tag()
 - Merge branch 'jk/parse-object-type-mismatch' into ab/tag-object-type-errors

 Hardening checks around mismatched object types when one of those
 objects is a tag.

 Expecting a reroll.
 cf. <xmqqzgb5jz5c.fsf@gitster.g>
 cf. <xmqqsfgxjugi.fsf@gitster.g>
 source: <cover-0.4-00000000000-20221118T113442Z-avarab@gmail.com>


* ad/test-record-count-when-harness-is-in-use (2022-12-25) 1 commit
 - test-lib: allow storing counts with test harnesses

 Allow summary results from tests to be written to t/test-results
 directory even when a test harness like 'prove' is in use.

 Expecting a reroll.
 cf. <CABPp-BGoPuGCZw+9wCgdYyRR4Zf4y9Kun27GrQhtMdYWpOUsYQ@mail.gmail.com>
 source: <20221224225200.1027806-1-adam@dinwoodie.org>


* so/diff-merges-more (2022-12-18) 5 commits
 - diff-merges: improve --diff-merges documentation
 - diff-merges: issue warning on lone '-m' option
 - diff-merges: support list of values for --diff-merges
 - diff-merges: implement log.diffMerges-m-imply-p config
 - diff-merges: implement [no-]hide option and log.diffMergesHide config

 Assorted updates to "--diff-merges=X" option.

 May want to discard.
 Breaking compatibility does not seem worth it.
 source: <20221217132955.108542-1-sorganov@gmail.com>


* ab/imap-send-requires-curl (2023-02-02) 6 commits
 - imap-send: correctly report "host" when using "tunnel"
 - imap-send: remove old --no-curl codepath
 - imap-send: make --curl no-optional
 - imap-send: replace auto-probe libcurl with hard dependency
 - imap-send doc: the imap.sslVerify is used with imap.tunnel
 - imap-send: note "auth_method", not "host" on auth method failure

 Give a hard dependency on cURL library to build "git imap-send",
 and remove the code to interact with IMAP server without using cURL.

 Expecting a reroll.
 The 'tunnel' part is still iffy.
 cf. <230203.86bkmabfjr.gmgdl@evledraar.gmail.com>
 source: <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>


* tc/cat-file-z-use-cquote (2023-03-03) 2 commits
 . cat-file: quote-format name in error when using -z
 . cat-file: extract printing batch error message into function

 "cat-file" in the batch mode that is fed NUL-terminated pathnames
 learned to cquote them in its error output (otherwise, a funny
 pathname with LF in it would break the lines in the output stream).

 Breaks "cat-file --batch-all-objects --batch-check".
 cf. <xmqqilfhctrr.fsf@gitster.g>
 source: <20230303191708.77894-1-toon@iotcl.com>


* cw/submodule-status-in-parallel (2023-03-02) 6 commits
 - diff-lib: parallelize run_diff_files for submodules
 - diff-lib: refactor out diff_change logic
 - submodule: refactor is_submodule_modified()
 - submodule: move status parsing into function
 - submodule: rename strbuf variable
 - run-command: add on_stderr_output_fn to run_processes_parallel_opts

 "git submodule status" learned to run the comparison in submodule
 repositories in parallel.

 Expecting a reroll.
 cf. <CAFySSZDk05m6gU5-V1R+y3YnQ5PPduVW54+_gjBwD0rmacsLsw@mail.gmail.com>
 cf. <230307.865ybc273g.gmgdl@evledraar.gmail.com>
 source: <20230302215237.1473444-1-calvinwan@google.com>

--------------------------------------------------
[Cooking]

* fc/doc-drop-custom-callout-format (2023-05-03) 1 commit
  (merged to 'next' on 2023-05-04 at c2fd654367)
 + doc: remove custom callouts format

 Our custom callout formatter is no longer used in the documentation
 formatting toolchain, as the upstream default ones give better
 output these days.

 Will merge to 'master'.
 source: <20230418011828.47851-1-felipe.contreras@gmail.com>


* fc/doc-man-lift-title-length-limit (2023-05-03) 1 commit
  (merged to 'next' on 2023-05-04 at d048eb1ef8)
 + doc: manpage: remove maximum title length

 The titles of manual pages (formatted with AsciiDoc) used to be
 chomped at unreasonably short limit, which has been removed; this
 makes the formatted output match that of asciidoctor.

 Will merge to 'master'.
 source: <20230503171658.8996-1-felipe.contreras@gmail.com>


* sd/doc-gitignore-and-rm-cached (2023-05-03) 1 commit
  (merged to 'next' on 2023-05-04 at a4b1b128d6)
 + docs: clarify git rm --cached function in gitignore note

 Doc update.

 Will merge to 'master'.
 source: <pull.862.v3.git.git.1683150400953.gitgitgadget@gmail.com>


* tb/pack-extra-cruft-tips (2023-05-03) 1 commit
 - builtin/pack-objects.c: introduce `pack.extraCruftTips`

 "git pack-objects" learned to invoke a new hook program that
 enumerates extra objects to be used as anchoring points to keep
 otherwise unreachable objects in cruft packs.

 Under discussion
 cf. <20230505221921.GE3321533@coredump.intra.peff.net>
 source: <27a7f16aab35b5cac391d9831aadb0f2e2146313.1683151485.git.me@ttaylorr.com>


* jc/diff-s-with-other-options (2023-05-05) 1 commit
 - diff: fix interaction between the "-s" option and other options
 (this branch uses jc/dirstat-plug-leaks.)

 The "-s" (silent, squelch) option of the "diff" family of commands
 did not interact with other options that specify the output format
 well.  This has been cleaned up so that it will clear all the
 formatting options given before.

 Will merge to 'next'?
 source: <20230505165952.335256-1-gitster@pobox.com>


* fc/asciidoc-code-block-hack (2023-05-04) 2 commits
 - doc: manpage: remove ancient workaround
 - doc: git-svn: use listing instead of verse

 Documentation toolchain lost an ancient workaround that is no
 longer needed.

 Needs review.
 source: <20230504035517.329765-1-felipe.contreras@gmail.com>


* fc/doc-revisions-markup-fix (2023-05-04) 2 commits
 - doc: revisions: add a bunch of missing quotes
 - doc: revisions: fix missing escape

 Doc cleanup.

 Needs review.
 source: <20230504163421.100400-1-felipe.contreras@gmail.com>


* fc/doc-use-datestamp-in-commit (2023-05-05) 2 commits
  (merged to 'next' on 2023-05-06 at 1eda43b03f)
 + doc-diff: drop SOURCE_DATE_EPOCH override
 + doc: doc-diff: specify date

 An earlier change broke "doc-diff", which has been corrected.

 Will merge to 'master'.
 source: <20230503232349.59997-1-felipe.contreras@gmail.com>
 source: <20230505211610.GA3197168@coredump.intra.peff.net>


* jc/dirstat-plug-leaks (2023-05-05) 2 commits
  (merged to 'next' on 2023-05-09 at 2df7cf06e4)
 + diff: plug leaks in dirstat
 + diff: refactor common tail part of dirstat computation
 (this branch is used by jc/diff-s-with-other-options.)

 "git diff --dirstat" leaked memory, which has been plugged.

 Will merge to 'master'.
 source: <20230505211917.2746751-1-gitster@pobox.com>


* jc/name-rev-deprecate-stdin-further (2023-05-06) 1 commit
  (merged to 'next' on 2023-05-09 at 0db4f08e32)
 + name-rev: make --stdin hidden

 The "--stdin" option of "git name-rev" has been replaced with
 the "--annotate-stdin" option more than a year ago.  We stop
 advertising it in the "git name-rev -h" output.

 Will merge to 'master'.
 source: <pull.1225.v3.git.git.1683346451239.gitgitgadget@gmail.com>


* ob/revert-of-revert (2023-05-05) 1 commit
 - sequencer: beautify subject of reverts of reverts

 Instead of "Revert "Revert "original"", give "Reapply "original""
 as the title for a revert of a revert.

 Expecting a hopefully final reroll.
 Looking much better, except for minor cosmetic issues.
 source: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>


* mh/use-wincred-from-system (2023-03-27) 1 commit
  (merged to 'next' on 2023-05-06 at a545c5d4aa)
 + credential/wincred: include wincred.h

 Code clean-up.

 Will merge to 'master'.
 cf. <8511e030-8167-715c-5ed4-1646e6e9ef85@gmx.de>
 cf. <CAGJzqsm4LmpYE46v2=y4=A+Och44zaQyzTXQRteX-KNSzA_18g@mail.gmail.com>
 source: <pull.1496.git.1679707396407.gitgitgadget@gmail.com>


* jc/attr-source-tree (2023-05-06) 1 commit
 - attr: teach "--attr-source=<tree>" global option to "git"

 "git --attr-source=<tree> cmd $args" is a new way to have any
 command to read attributes not from the working tree but from the
 given tree object.

 Will merge to 'next'.
 source: <pull.1470.v6.git.git.1683346530487.gitgitgadget@gmail.com>


* mc/send-email-header-cmd (2023-05-01) 3 commits
  (merged to 'next' on 2023-05-06 at 04514468b6)
 + send-email: detect empty blank lines in command output
 + send-email: add --header-cmd, --no-header-cmd options
 + send-email: extract execute_cmd from recipients_cmd

 "git send-email" learned "--header-cmd=<cmd>" that can inject
 arbitrary e-mail header lines to the outgoing messages.

 Will merge to 'master'.
 source: <20230501143848.19674-1-maxim.cournoyer@gmail.com>


* rs/test-ctype-eof (2023-05-02) 1 commit
  (merged to 'next' on 2023-05-02 at a19201a6a9)
 + test-ctype: check EOF

 ctype tests have been taught to test EOF, too.

 Will merge to 'master'.
 source: <1dbbd7ce-2b3f-6f88-f902-1d4ffe62e259@web.de>


* tb/credential-long-lines (2023-05-01) 7 commits
  (merged to 'next' on 2023-05-02 at f027002b92)
 + contrib/credential: embiggen fixed-size buffer in wincred
 + contrib/credential: avoid fixed-size buffer in libsecret
 + contrib/credential: .gitignore libsecret build artifacts
 + contrib/credential: remove 'gnome-keyring' credential helper
 + contrib/credential: avoid fixed-size buffer in osxkeychain
 + t/lib-credential.sh: ensure credential helpers handle long headers
 + credential.c: store "wwwauth[]" values in `credential_read()`

 The implementation of credential helpers used fgets() over fixed
 size buffers to read protocol messages, causing the remainder of
 the folded long line to trigger unexpected behaviour, which has
 been corrected.

 Will merge to 'master'.
 source: <cover.1682956419.git.me@ttaylorr.com>


* bc/clone-empty-repo-via-protocol-v0 (2023-05-01) 1 commit
 - upload-pack: advertise capabilities when cloning empty repos

 Expecting a minor and hopefully final update.
 cf. <20230501224038.GA1174291@coredump.intra.peff.net>
 source: <20230501170018.1410567-2-sandals@crustytoothpaste.net>


* ds/fsck-bitmap (2023-05-02) 2 commits
  (merged to 'next' on 2023-05-09 at c2148408a2)
 + fsck: use local repository
 + fsck: verify checksums of all .bitmap files

 "git fsck" learned to detect bit-flip breakages in the reachability
 bitmap files.

 Will merge to 'master'.
 source: <pull.1526.v2.git.1683034042.gitgitgadget@gmail.com>


* gc/trace-bare-repo-setup (2023-05-01) 1 commit
  (merged to 'next' on 2023-05-06 at 72b977d2f9)
 + setup: trace bare repository setups

 The tracing mechanism learned to notice and report when
 auto-discovered bare repositories are being used, as allowing so
 without explicitly stating the user intends to do so (with setting
 GIT_DIR for example) can be used with social engineering as an
 attack vector.

 Will merge to 'master'.
 source: <e98be8e7f703fc741e06d9208545abc8c24d1a4a.1682962110.git.steadmon@google.com>


* cw/strbuf-cleanup (2023-05-08) 7 commits
 - strbuf: remove global variable
 - strbuf: clarify dependency
 - path: move related function to path
 - object-name: move related functions to object-name
 - credential-store: move related functions to credential-store file
 - abspath: move related functions to abspath
 - strbuf: clarify API boundary

 Move functions that are not about pure string manipulation out of
 strbuf.[ch]

 Comments?
 source: <20230508165728.525603-1-calvinwan@google.com>


* ah/doc-attributes-text (2023-05-03) 1 commit
  (merged to 'next' on 2023-05-04 at 121c97817e)
 + docs: rewrite the documentation of the text and eol attributes

 Doc update to clarify how text and eol attributes interact to
 specify the end-of-line conversion.

 Will merge to 'master'.
 source: <20230503044656.221175-2-alexhenrie24@gmail.com>


* hx/negotiator-non-recursive (2023-04-26) 2 commits
  (merged to 'next' on 2023-05-02 at 64f97cc72d)
 + negotiator/skipping: fix some problems in mark_common()
 + negotiator/default: avoid stack overflow

 The implementation of the default "negotiator", used to find common
 ancestor over the network for object tranfer, used to be recursive;
 it was updated to be iterative to conserve stackspace usage.

 Will merge to 'master'.
 cf. <9ad5f246-e21f-0a13-1a53-1ae3307c3f0e@github.com>
 source: <cover.1682513384.git.hanxin.hx@bytedance.com>


* jc/doc-clarify-git-default-hash-variable (2023-04-26) 1 commit
  (merged to 'next' on 2023-05-06 at 7bae4db4cc)
 + doc: GIT_DEFAULT_HASH is and will be ignored during "clone"

 The documentation was misleading about the interaction between
 GIT_DEFAULT_HASH and "git clone", which has been clarified to
 stress that the variable is to be ignored by the command.

 Will merge to 'master'.
 source: <xmqqzg6uvfpo.fsf_-_@gitster.g>


* tl/notes-separator (2023-04-28) 6 commits
  (merged to 'next' on 2023-05-06 at 598ed19c9b)
 + notes.c: introduce "--[no-]stripspace" option
 + notes.c: append separator instead of insert by pos
 + notes.c: introduce '--separator=<paragraph-break>' option
 + t3321: add test cases about the notes stripspace behavior
 + notes.c: use designated initializers for clarity
 + notes.c: cleanup 'strbuf_grow' call in 'append_edit'

 'git notes append' was taught '--separator' to specify string to insert
 between paragraphs.

 Will merge to 'master'.
 source: <cover.1682671758.git.dyroneteng@gmail.com>


* pw/rebase-i-after-failure (2023-04-21) 6 commits
 - rebase -i: fix adding failed command to the todo list
 - rebase: fix rewritten list for failed pick
 - rebase --continue: refuse to commit after failed command
 - sequencer: factor out part of pick_commits()
 - rebase -i: remove patch file after conflict resolution
 - rebase -i: move unlink() calls

 Various fixes to the behaviour of "rebase -i" when the command got
 interrupted by conflicting changes.

 Expecting a reroll.
 cf. <xmqqsfcthrpb.fsf@gitster.g>
 cf. <1fd54422-b66a-c2e4-7cd7-934ea01190ad@gmail.com>
 source: <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>


* sl/sparse-write-tree-part-2 (2023-05-08) 1 commit
 - t1092: update a write-tree test

 Fix-up to a topic already graduated to 'master'.

 Will merge to 'next'?
 source: <20230508202140.464363-1-cheskaqiqi@gmail.com>


* tb/pack-bitmap-traversal-with-boundary (2023-05-08) 3 commits
 - pack-bitmap.c: use commit boundary during bitmap traversal
 - pack-bitmap.c: extract `fill_in_bitmap()`
 - object: add object_array initializer helper function

 The object traversal using reachability bitmap done by
 "pack-object" has been tweaked to take advantage of the fact that
 using "boundary" commits as representative of all the uninteresting
 ones can save quite a lot of object enumeration.
 source: <cover.1683567065.git.me@ttaylorr.com>


* ar/config-count-tests-updates (2023-04-24) 3 commits
  (merged to 'next' on 2023-05-06 at c585a56132)
 + t1300: add tests for missing keys
 + t1300: check stderr for "ignores pairs" tests
 + t1300: drop duplicate test

 Test updates.

 Will merge to 'master'.
 source: <20230423134649.431783-1-rybak.a.v@gmail.com>


* ps/fetch-output-format (2023-05-09) 8 commits
 - fetch: introduce machine-parseable "porcelain" output format
 - fetch: move option related variables into main function
 - fetch: move display format parsing into main function
 - fetch: introduce `display_format` enum
 - fetch: fix missing from-reference when fetching HEAD:foo
 - fetch: add a test to exercise invalid output formats
 - fetch: split out tests for output format
 - fetch: fix `--no-recurse-submodules` with multi-remote fetches

 "git fetch" learned the "--porcelain" option that emits what it did
 in a machine-parseable format.

 Getting there.
 source: <cover.1683636885.git.ps@pks.im>


* ma/gittutorial-fixes (2023-04-20) 2 commits
  (merged to 'next' on 2023-05-02 at bf96011972)
 + gittutorial: wrap literal examples in backticks
 + gittutorial: drop early mention of origin

 Doc fixes.

 Will merge to 'master'.
 source: <cover.1681579244.git.martin.agren@gmail.com>


* sg/retire-unused-cocci (2023-04-20) 1 commit
 - cocci: remove 'unused.cocci'

 Retire a rather expensive-to-run Coccinelle check patch.
 source: <20230420205350.600760-1-szeder.dev@gmail.com>


* ms/send-email-feed-header-to-validate-hook (2023-04-19) 2 commits
  (merged to 'next' on 2023-05-03 at ba7079bcd4)
 + send-email: expose header information to git-send-email's sendemail-validate hook
 + send-email: refactor header generation functions

 "git send-email" learned to give the e-mail headers to the validate
 hook by passing an extra argument from the command line.

 Will merge to 'master'.
 source: <20230419202703.2911836-1-michael.strawbridge@amd.com>


* gc/doc-cocci-updates (2023-04-27) 2 commits
 - cocci: codify authoring and reviewing practices
 - cocci: add headings to and reword README

 Update documentation regarding Coccinelle patches.

 Will merge to 'next'?
 source: <pull.1495.v2.git.git.1682634143.gitgitgadget@gmail.com>


* kh/doc-interpret-trailers-updates (2023-05-01) 4 commits
  (merged to 'next' on 2023-05-06 at 4e9a640131)
 + doc: interpret-trailers: fix example
 + doc: interpret-trailers: don’t use deprecated config
 + doc: interpret-trailers: use input redirection
 + doc: interpret-trailers: don’t use heredoc in examples

 Doc update.

 Will merge to 'master'.
 source: <cover.1682970213.git.code@khaugsbakk.name>


* pb/complete-and-document-auto-merge-and-friends (2023-04-14) 5 commits
  (merged to 'next' on 2023-04-20 at 2728a01622)
 + completion: complete AUTO_MERGE
 + Documentation: document AUTO_MERGE
 + git-merge.txt: modernize word choice in "True merge" section
 + completion: complete REVERT_HEAD and BISECT_HEAD
 + revisions.txt: document more special refs

 Document more pseudo-refs and teach the command line completion
 machinery to complete AUTO_MERGE.

 On hold, waiting for a fix-up.
 cf. <a10648d5-8cba-4c7c-a303-b5b0dcdd3310@gmail.com>
 source: <pull.1515.git.1681495119.gitgitgadget@gmail.com>


* ar/test-cleanup-unused-file-creation-part2 (2023-05-03) 6 commits
  (merged to 'next' on 2023-05-03 at 185f0ec195)
 + t2019: don't create unused files
 + t1502: don't create unused files
 + t1450: don't create unused files
 + t1300: don't create unused files
 + t1300: fix config file syntax error descriptions
 + t0300: don't create unused file

 Test cleanup.

 Will merge to 'master'.
 cf. <CABPp-BFCBPTBc9savP13gNFmBo_WCnZHUv_Z8bWE6T6GZOrs-Q@mail.gmail.com>
 source: <20230417191044.909094-1-rybak.a.v@gmail.com>


* mh/credential-password-expiry-wincred (2023-04-03) 1 commit
  (merged to 'next' on 2023-05-06 at 51aae61f60)
 + credential/wincred: store password_expiry_utc

 Teach the recently invented "password expiry time" trait to the
 wincred credential helper.

 Will merge to 'master'.
 cf. <CAGJzqsm4LmpYE46v2=y4=A+Och44zaQyzTXQRteX-KNSzA_18g@mail.gmail.com>
 source: <pull.1477.v3.git.git.1680508028077.gitgitgadget@gmail.com>


* mh/credential-oauth-refresh-token (2023-04-21) 1 commit
  (merged to 'next' on 2023-05-04 at 9ade4aa024)
 + credential: new attribute oauth_refresh_token

 The credential subsystem learns to help OAuth framework.

 Will merge to 'master'.
 source: <pull.1394.v2.git.1682070479816.gitgitgadget@gmail.com>


* mh/credential-password-expiry-libsecret (2023-05-05) 1 commit
  (merged to 'next' on 2023-05-09 at fd898e3756)
 + credential/libsecret: support password_expiry_utc

 The libsecret credential helper learns to handle the password
 expiry time information.

 Will merge to 'master'.
 source: <pull.1469.v3.git.git.1683270298313.gitgitgadget@gmail.com>


* sl/diff-files-sparse (2023-05-09) 2 commits
 - diff-files: integrate with sparse index
 - t1092: add tests for `git diff-files`

 Teach "diff-files" not to expand sparse-index unless needed.

 Will merge to 'next'?
 source: <20230509194241.469477-1-cheskaqiqi@gmail.com>


* rj/branch-unborn-in-other-worktrees (2023-03-27) 5 commits
  (merged to 'next' on 2023-05-06 at c61e9b0672)
 + branch: avoid unnecessary worktrees traversals
 + branch: rename orphan branches in any worktree
 + branch: description for orphan branch errors
 + branch: use get_worktrees() in copy_or_rename_branch()
 + branch: test for failures while renaming branches

 Error messages given when working on an unborn branch that is
 checked out in another worktree have been improved.

 Will merge to 'master'.
 source: <f8e6447e-5cd3-98fa-f567-39e1c60dacb0@gmail.com>

--------------------------------------------------
[Discarded]

* ed/fsmonitor-inotify (2022-12-13) 6 commits
 . fsmonitor: update doc for Linux
 . fsmonitor: test updates
 . fsmonitor: enable fsmonitor for Linux
 . fsmonitor: implement filesystem change listener for Linux
 . fsmonitor: determine if filesystem is local or remote
 . fsmonitor: prepare to share code between Mac OS and Linux

 Bundled fsmonitor for Linux using inotify API.

 Seems to break asan job at CI when merged to 'seen'.
 cf. <xmqqzg7d8xn2.fsf@gitster.g>
 source: <pull.1352.v5.git.git.1670882286.gitgitgadget@gmail.com>


* my/wildmatch-cleanups (2023-02-27) 5 commits
 . wildmatch: more cleanups after killing uchar
 . wildmatch: use char instead of uchar
 . wildmatch: remove NEGATE_CLASS(2) macros with trivial refactoring
 . wildmatch: remove IS*() macros
 . git-compat-util: add isblank() and isgraph()

 Code clean-up.

 Discarded without prejudice after more than 6 weeks of inactivity.
 source: <20230226115021.1681834-1-masahiroy@kernel.org>


* cw/forbid-use-of-gitlink-outside-submodules (2023-02-28) 6 commits
 . add: reject nested repositories
 . tests: remove duplicate .gitmodules path
 . tests: use `git submodule add` and fix expected status
 . tests: use `git submodule add` and fix expected diffs
 . tests: Use `git submodule add` instead of `git add`
 . t4041, t4060: modernize test style

 Forbid "git add dir" from adding a gitlink to the index.

 Discarded without prejudice after more than 6 weeks of inactivity.
 source: <20230228185253.2356546-1-calvinwan@google.com>


* nw/for-each-ref-signature (2023-03-13) 1 commit
 . ref-filter: add new "signature" atom

 "git (for-each-ref|branch|tag) --format=<format>" learns the "%(signature)"
 placeholder and friends.

 Breaks CI.
 cf. <xmqqpm9bosjw.fsf@gitster.g>
 source: <20230311210607.64927-2-nsengiyumvawilberforce@gmail.com>
