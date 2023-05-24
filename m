Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F8AC77B7C
	for <git@archiver.kernel.org>; Wed, 24 May 2023 22:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbjEXWpu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 May 2023 18:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjEXWpt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2023 18:45:49 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC17B3
        for <git@vger.kernel.org>; Wed, 24 May 2023 15:45:44 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d5b4c3ffeso1145915b3a.2
        for <git@vger.kernel.org>; Wed, 24 May 2023 15:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684968344; x=1687560344;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jr/iGx5ifKVk9A0sebgATmRLd4qy7moCtCtBcLh5+pE=;
        b=MeR3qSgQp55sfQq1aAbKE9Z0ronX8Oy6KT+ksAK2Ftoe/2gQJ2/QYyigTLrOWcEj7E
         /ksRhsk4WPMAKXwEIiCxWwKUCCuSgdh8OaDor5MusUtzjstVg4PGLB74zQugQp1QqWn0
         rgQKbH70Yys5KFc6QVdeDxFaFzmrdmpXvj6/q0K+n+x1E4W+aIThnH1Ljnyk/q3/2BKV
         nvcfCq3ad78dsMnIdXu2rcBPxhwDtJEI6ACyNcH1WLf2RonQFiXlTm2+TCgYW4FOMVIe
         hrkeiihHbxTDU9AAfecrZZfY89DeAlg4D4FqQ7JBRQLEngDrA2VescO/0P+0gJs90oEh
         HmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684968344; x=1687560344;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jr/iGx5ifKVk9A0sebgATmRLd4qy7moCtCtBcLh5+pE=;
        b=Tj4C3twSiM81OkqNqoTyYxPPwyZWlcHvGQVDrc/LQ6C4YOxzNUrfsGax8cBKWixdnh
         iybU23IfaIjtXqfhsvTWsotfiCtKgxEOD55lf1yW5+8JPSenxKFuxRLivCChzqhNJ0Gw
         Gak0LVALLn7fCqKT1vugb1rOSFNg++tAznv+OSm5L1kr6BsVRDDRnM/gMs16/KyEmJRd
         4lV9V0bNtApyD0yfPiwfR9dXNF2ckbZWNeRTO5QrMppS1sPwgQLFkrOrRwfT3X23mZlY
         1pqL2acbk7RnImbjH/WtWoTtLErCeGXPX6XAw2MRCt+AiMljwaylvelEBxdwkVPvIlY9
         5ZRA==
X-Gm-Message-State: AC+VfDydI2UoBoGbY2ieoM6BKYGxqxqGcASyaLDOtlT3md3JiFo8NvUo
        o2N2+QwFpQXS8A0XfyNZuk0mcPdlanjxPg==
X-Google-Smtp-Source: ACHHUZ5czGWAh3wTE1aD1nse2Fh2WQ/RhGrJlK6dEGzWcaCHt5Ita3Wn/HO7GWYZ/2NXivo+K4QZDA==
X-Received: by 2002:a05:6a00:2287:b0:63b:19e5:a9ec with SMTP id f7-20020a056a00228700b0063b19e5a9ecmr5893907pfe.33.1684968343333;
        Wed, 24 May 2023 15:45:43 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id d1-20020aa78e41000000b00640dbf177b8sm7940941pfr.37.2023.05.24.15.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 15:45:42 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (May 2023, #08; Thu, 25)
X-master-at: 79bdd48716a4c455bdc8ffd91d57a18d5cd55baa
X-next-at: 9c6817b8e7dd4f282c873014c94d11929874b708
Date:   Thu, 25 May 2023 07:45:42 +0900
Message-ID: <xmqqzg5te4bt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
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

Git 2.41-rc2 has been tagged.

Until early June, I am on half-vacation, and my bandwidth may be
limited and availability rather sporadic.

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

* sl/sparse-write-tree-part-2 (2023-05-08) 1 commit
  (merged to 'next' on 2023-05-23 at 317fd52454)
 + t1092: update a write-tree test

 Fix-up to a topic already graduated to 'master'.
 source: <20230508202140.464363-1-cheskaqiqi@gmail.com>

--------------------------------------------------
[New Topics]

* vd/worktree-config-is-per-repository (2023-05-24) 2 commits
 - repository: move 'repository_format_worktree_config' to repo scope
 - config: use gitdir to get worktree config

 The value of config.worktree is per-repository, but has been kept
 in a singleton global variable per process. This has been OK as
 most Git operations interacted with a single repository at a time,
 but not right for operations like recursive "grep" that want to
 access multiple repositories from a single process without forking.

 The global variable has been eliminated and made into a member in
 the per-repository data structure.

 Needs review.
 source: <pull.1536.git.1684883872.gitgitgadget@gmail.com>


* tb/submodule-null-deref-fix (2023-05-25) 1 commit
 - builtin/submodule--helper.c: handle missing submodule URLs

 "git submodule" code trusted the data coming from the config (and
 the in-tree .gitmodules file) too much without validating, leading
 to NULL dereference if the user mucks with a repository (e.g.
 submodule.<name>.url is removed).  This has been corrected.

 Will merge to 'next'?
 source: <ae6cf3fa461b85e346f034371dae56a2790dfa20.1684957882.git.me@ttaylorr.com>

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


* ab/tag-object-type-errors (2023-05-10) 4 commits
 - tag: don't emit potentially incorrect "object is a X, not a Y"
 - tag: don't misreport type of tagged objects in errors
 - object tests: add test for unexpected objects in tags
 - Merge branch 'jk/parse-object-type-mismatch' into ab/tag-object-type-errors

 Hardening checks around mismatched object types when one of those
 objects is a tag.
 source: <cover-v2-0.3-00000000000-20221230T011725Z-avarab@gmail.com>


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

* jc/test-modernization-2 (2023-05-23) 10 commits
 - t9400-git-cvsserver-server: modernize test format
 - t9200-git-cvsexportcommit: modernize test format
 - t9104-git-svn-follow-parent: modernize test format
 - t9100-git-svn-basic: modernize test format
 - t7700-repack: modernize test format
 - t7600-merge: modernize test format
 - t7508-status: modernize test format
 - t7201-co: modernize test format
 - t7111-reset-table: modernize test format
 - t7110-reset-merge: modernize test format
 (this branch uses jc/test-modernization.)

 Test style updates.
 source: <pull.1514.git.git.1684599239.gitgitgadget@gmail.com>


* jt/path-filter-fix (2023-05-23) 2 commits
 - commit-graph: fix murmur3, bump filter ver. to 2
 - t4216: test wrong bloom filter version rejection

 The Bloom filter used for path limited history traversal was broken
 on systems whose "char" is unsigned; update the implementation and
 bump the format version to 2.

 Needs a more careful transition?
 cf. <def26c71-0fbb-58a3-f1cd-f8e532b67503@github.com>
 source: <cover.1684790529.git.jonathantanmy@google.com>


* tk/cherry-pick-sequence-requires-clean-worktree (2023-05-23) 1 commit
 - cherry-pick: refuse cherry-pick sequence if index is dirty

 "git cherry-pick A" that replays a single commit stopped before
 clobbering local modification, but "git cherry-pick A..B" did not,
 which has been corrected.

 Expecting a reroll.
 cf. <pull.1535.git.1684830767336.gitgitgadget@gmail.com>
 source: <pull.1535.git.1684830767336.gitgitgadget@gmail.com>


* mh/credential-libsecret-attrs (2023-05-17) 1 commit
 - credential/libsecret: store new attributes

 The way authentication related data other than passwords (e.g.
 oath token and password expiration data) are stored in libsecret
 keyrings has been rethought.

 Needs review.
 source: <pull.1469.v4.git.git.1684306540947.gitgitgadget@gmail.com>


* ps/fetch-cleanups (2023-05-17) 9 commits
 - fetch: use `fetch_config` to store "submodule.fetchJobs" value
 - fetch: use `fetch_config` to store "fetch.parallel" value
 - fetch: use `fetch_config` to store "fetch.recurseSubmodules" value
 - fetch: use `fetch_config` to store "fetch.showForcedUpdates" value
 - fetch: use `fetch_config` to store "fetch.pruneTags" value
 - fetch: use `fetch_config` to store "fetch.prune" value
 - fetch: pass through `fetch_config` directly
 - fetch: drop unneeded NULL-check for `remote_ref`
 - fetch: drop unused DISPLAY_FORMAT_UNKNOWN enum value

 Code clean-up.

 Needs review.
 source: <cover.1684324059.git.ps@pks.im>


* sl/diff-tree-sparse (2023-05-18) 1 commit
  (merged to 'next' on 2023-05-24 at 5d4f2dec4d)
 + diff-tree: integrate with sparse index

 "git diff-tree" has been taught to take advantage of the
 sparse-index feature.

 Will cook in 'next'.
 cf. <2a2b7223-bb5d-65f9-95bb-9be45d329c87@github.com>
 source: <20230518154454.475487-1-cheskaqiqi@gmail.com>


* jk/format-patch-message-id-unleak (2023-05-19) 2 commits
  (merged to 'next' on 2023-05-23 at 44b9e1ab91)
 + format-patch: free elements of rev.ref_message_ids list
 + format-patch: free rev.message_id when exiting

 Leakfix.

 Will cook in 'next'.
 source: <20230519000239.GA1975039@coredump.intra.peff.net>


* jc/test-modernization (2023-05-19) 20 commits
 - t7101-reset-empty-subdirs: modernize test format
 - t6050-replace: modernize test format
 - t5306-pack-nobase: modernize test format
 - t5303-pack-corruption-resilience: modernize test format
 - t5301-sliding-window: modernize test format
 - t5300-pack-object: modernize test format
 - t4206-log-follow-harder-copies: modernize test format
 - t4202-log: modernize test format
 - t4004-diff-rename-symlink: modernize test format
 - t4003-diff-rename-1: modernize test format
 - t4002-diff-basic: modernize test format
 - t3903-stash: modernize test format
 - t3700-add: modernize test format
 - t3500-cherry: modernize test format
 - t1006-cat-file: modernize test format
 - t1002-read-tree-m-u-2way: modernize test format
 - t1001-read-tree-m-2way: modernize test format
 - t3210-pack-refs: modernize test format
 - t0030-stripspace: modernize test format
 - t0000-basic: modernize test format
 (this branch is used by jc/test-modernization-2.)

 source: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>


* ja/worktree-orphan (2023-05-17) 8 commits
 - worktree add: emit warn when there is a bad HEAD
 - worktree add: extend DWIM to infer --orphan
 - worktree add: introduce "try --orphan" hint
 - worktree add: add --orphan flag
 - t2400: add tests to verify --quiet
 - t2400: refactor "worktree add" opt exclusion tests
 - t2400: cleanup created worktree in test
 - worktree add: include -B in usage docs

 'git worktree add' learned how to create a worktree based on an
 orphaned branch with `--orphan`.
 source: <20230517214711.12467-1-jacobabel@nullpo.dev>


* kh/keep-tag-editmsg-upon-failure (2023-05-16) 3 commits
  (merged to 'next' on 2023-05-19 at fc0fe3173d)
 + tag: keep the message file in case ref transaction fails
 + t/t7004-tag: add regression test for successful tag creation
 + doc: tag: document `TAG_EDITMSG`

 "git tag" learned to leave the "$GIT_DIR/TAG_EDITMSG" file when the
 command failed, so that the user can salvage what they typed.

 Will cook in 'next'.
 source: <cover.1684258780.git.code@khaugsbakk.name>


* sa/doc-ls-remote (2023-05-19) 6 commits
  (merged to 'next' on 2023-05-20 at d577bf75a0)
 + ls-remote doc: document the output format
 + ls-remote doc: explain what each example does
 + ls-remote doc: show peeled tags in examples
 + ls-remote doc: remove redundant --tags example
 + show-branch doc: say <ref>, not <reference>
 + show-ref doc: update for internal consistency

 Doc update.

 Will cook in 'next'.
 source: <pull.1471.v4.git.git.1684469874.gitgitgadget@gmail.com>


* tb/refs-exclusion-and-packed-refs (2023-05-15) 16 commits
 - ls-refs.c: avoid enumerating hidden refs where possible
 - upload-pack.c: avoid enumerating hidden refs where possible
 - builtin/receive-pack.c: avoid enumerating hidden references
 - refs.h: let `for_each_namespaced_ref()` take excluded patterns
 - refs/packed-backend.c: ignore complicated hidden refs rules
 - revision.h: store hidden refs in a `strvec`
 - refs/packed-backend.c: add trace2 counters for jump list
 - refs/packed-backend.c: implement jump lists to avoid excluded pattern(s)
 - refs/packed-backend.c: refactor `find_reference_location()`
 - refs: plumb `exclude_patterns` argument throughout
 - builtin/for-each-ref.c: add `--exclude` option
 - ref-filter.c: parameterize match functions over patterns
 - ref-filter: add `ref_filter_clear()`
 - ref-filter: clear reachable list pointers after freeing
 - ref-filter.h: provide `REF_FILTER_INIT`
 - refs.c: rename `ref_filter`

 Enumerating refs in the packed-refs file, while excluding refs that
 match certain patterns, has been optimized.

 Will merge to 'next'?
 source: <cover.1684178576.git.me@ttaylorr.com>


* zh/ls-files-format-atoms (2023-05-23) 1 commit
  (merged to 'next' on 2023-05-24 at 116b11effb)
 + ls-files: align format atoms with ls-tree

 Some atoms that can be used in "--format=<format>" for "git ls-tree"
 were not supported by "git ls-files", even though they were relevant
 in the context of the latter.

 Will cook in 'next'.
 source: <pull.1533.v2.git.1684832418299.gitgitgadget@gmail.com>


* tc/cat-file-z-use-cquote (2023-05-10) 1 commit
 - cat-file: quote-format name in error when using -z

 "cat-file" in the batch mode that is fed NUL-terminated pathnames
 learned to cquote them in its error output (otherwise, a funny
 pathname with LF in it would break the lines in the output stream).

 Redesign.
 source: <20230510190116.795641-2-toon@iotcl.com>


* en/header-split-cache-h-part-3 (2023-05-16) 29 commits
 - fsmonitor-ll.h: split this header out of fsmonitor.h
 - hash-ll, hashmap: move oidhash() to hash-ll
 - object-store-ll.h: split this header out of object-store.h
 - khash: name the structs that khash declares
 - merge-ll: rename from ll-merge
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
 - init-db: remove unnecessary global variable
 - init-db: document existing bug with core.bare in template config
 - Merge branch 'en/header-split-cache-h-part-2' into en/header-split-cache-h-part-3

 Header files cleanup.
 source: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>


* la/doc-interpret-trailers (2023-05-11) 9 commits
 - doc: trailer: add more examples in DESCRIPTION
 - doc: trailer: mention 'key' in DESCRIPTION
 - doc: trailer.<token>.command: emphasize deprecation
 - doc: trailer: use angle brackets for <token> and <value>
 - doc: trailer: remove redundant phrasing
 - doc: trailer: examples: avoid the word "message" by itself
 - doc: trailer: drop "commit message part" phrasing
 - doc: trailer: swap verb order
 - doc: trailer: fix grammar

 Doc update.

 On hold. Looking good.
 Want to be rebased once kh/doc-interpret-trailers-updates lands.
 source: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>


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


* jc/pack-ref-exclude-include (2023-05-12) 3 commits
  (merged to 'next' on 2023-05-23 at 37333a2d00)
 + pack-refs: teach pack-refs --include option
 + pack-refs: teach --exclude option to exclude refs from being packed
 + docs: clarify git-pack-refs --all will pack all refs

 "git pack-refs" learns "--include" and "--exclude" to tweak the ref
 hierarchy to be packed using pattern matching.

 Will cook in 'next'.
 source: <pull.1501.v4.git.git.1683927282.gitgitgadget@gmail.com>


* tb/gc-recent-object-hook (2023-05-15) 2 commits
 - gc: introduce `gc.recentObjectsHook`
 - reachable.c: extract `obj_is_recent()`

 "git pack-objects" learned to invoke a new hook program that
 enumerates extra objects to be used as anchoring points to keep
 otherwise unreachable objects in cruft packs.
 source: <cover.1684196634.git.me@ttaylorr.com>


* jc/diff-s-with-other-options (2023-05-05) 1 commit
  (merged to 'next' on 2023-05-20 at dda3826a68)
 + diff: fix interaction between the "-s" option and other options

 The "-s" (silent, squelch) option of the "diff" family of commands
 did not interact with other options that specify the output format
 well.  This has been cleaned up so that it will clear all the
 formatting options given before.

 Will cook in 'next'.
 source: <20230505165952.335256-1-gitster@pobox.com>


* ob/revert-of-revert (2023-05-05) 1 commit
 - sequencer: beautify subject of reverts of reverts

 Instead of "Revert "Revert "original"", give "Reapply "original""
 as the title for a revert of a revert.

 Expecting a hopefully final reroll.
 Looking much better, except for minor cosmetic issues.
 source: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>


* cw/strbuf-cleanup (2023-05-12) 7 commits
  (merged to 'next' on 2023-05-15 at 31d08296f2)
 + strbuf: remove global variable
 + strbuf: clarify dependency
 + path: move related function to path
 + object-name: move related functions to object-name
 + credential-store: move related functions to credential-store file
 + abspath: move related functions to abspath
 + strbuf: clarify API boundary

 Move functions that are not about pure string manipulation out of
 strbuf.[ch]

 Will cook in 'next'.
 source: <20230512171429.2202982-1-calvinwan@google.com>


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

 On hold.
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


* tb/pack-bitmap-traversal-with-boundary (2023-05-08) 3 commits
 - pack-bitmap.c: use commit boundary during bitmap traversal
 - pack-bitmap.c: extract `fill_in_bitmap()`
 - object: add object_array initializer helper function

 The object traversal using reachability bitmap done by
 "pack-object" has been tweaked to take advantage of the fact that
 using "boundary" commits as representative of all the uninteresting
 ones can save quite a lot of object enumeration.
 source: <cover.1683567065.git.me@ttaylorr.com>


* gc/doc-cocci-updates (2023-04-27) 2 commits
  (merged to 'next' on 2023-05-20 at 3fe237c1a8)
 + cocci: codify authoring and reviewing practices
 + cocci: add headings to and reword README

 Update documentation regarding Coccinelle patches.

 Will cook in 'next'.
 source: <pull.1495.v2.git.git.1682634143.gitgitgadget@gmail.com>


* pb/complete-and-document-auto-merge-and-friends (2023-05-23) 6 commits
 - completion: complete AUTO_MERGE
 - Documentation: document AUTO_MERGE
 - git-merge.txt: modernize word choice in "True merge" section
 - completion: complete REVERT_HEAD and BISECT_HEAD
 - revisions.txt: document more special refs
 - revisions.txt: use description list for special refs

 Document more pseudo-refs and teach the command line completion
 machinery to complete AUTO_MERGE.

 Kicked back to 'seen' and replaced.
 Needs review/ack.
 source: <pull.1515.v2.git.1684783741.gitgitgadget@gmail.com>


* mh/credential-password-expiry-libsecret (2023-05-05) 1 commit
  (merged to 'next' on 2023-05-09 at fd898e3756)
 + credential/libsecret: support password_expiry_utc

 The libsecret credential helper learns to handle the password
 expiry time information.

 On hold.
 The database gets littered with entries whose expiration dates only differ.
 cf. <CAGJzqskMwOJkriH6serqdwAVYi+fftEL8ohJd-suP6v+OxB_bg@mail.gmail.com>
 source: <pull.1469.v3.git.git.1683270298313.gitgitgadget@gmail.com>

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


* fc/asciidoc-code-block-hack (2023-05-04) 2 commits
 . doc: manpage: remove ancient workaround
 . doc: git-svn: use listing instead of verse

 Documentation toolchain lost an ancient workaround that is no
 longer needed.

 The contributor is no longer with the project.
 source: <20230504035517.329765-1-felipe.contreras@gmail.com>


* fc/doc-revisions-markup-fix (2023-05-04) 2 commits
 . doc: revisions: add a bunch of missing quotes
 . doc: revisions: fix missing escape

 Doc cleanup.

 The contributor is no longer with the project.
 source: <20230504163421.100400-1-felipe.contreras@gmail.com>
