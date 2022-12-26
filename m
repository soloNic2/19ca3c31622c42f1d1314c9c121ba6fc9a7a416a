Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED36C3DA79
	for <git@archiver.kernel.org>; Mon, 26 Dec 2022 03:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbiLZDiO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 22:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLZDiM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 22:38:12 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C258525C9
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 19:38:06 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id 4so9804234plj.3
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 19:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fYxssztsVl0ZeLoJYTz/LIX4Sx09bw7C+evSLRvBL58=;
        b=UGCUNEJjDWP12LdM/QV+X/NTsGwpaejHVysz0OZ7Na6NTkCytrGuA0yLRPAV7JPLkF
         WXVcPQgosi92GXQ7mhVHQxWZPgy6KvqDsQ+D8t7ioU7z6RRW67oXMDdgNacHhVmJAkAj
         Mos5ANJ2J7/YegYTNnRGIaHVZMljUPiqi/M1qkye6uPsmtFYF4pGay6LVT0n8AZHWk8i
         aPVUhxFTJfjtZ9r7uhIi6Almw36XRNIVm7CD8l3oTrC+xSWCdqQU1+gthG++m3JNGAFd
         wEOoDrTRiocTqEvjmsRjNUzhnPelML/EoHCaI3WDHtrj48KNa7hISSfgS/OIj9yYTVeq
         mq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fYxssztsVl0ZeLoJYTz/LIX4Sx09bw7C+evSLRvBL58=;
        b=nEYZ2d/KRc2Kd+IESRgOezcHm92EFRUBnTXDo9tnGok3Ep/TA5lgB8upxA3eQ41SEy
         rZWykyMPNP15IieOMtlH2aFUcZL4hk6Ygua60dSKZT8jEWCAFx1zxyOTwXgX+8ZaHvkO
         OLvEEQdb1u9e4BmnzgtZae7Wnft+bPSxoEXNMyvOltknEcTvofucWNgrj2gR0skd3anr
         evybfBRwvIxE1nyr423uvambBwmZWbENFiWlrU8DIbqRAdKpO0d8T/UthD9vd/C2oo3T
         OgjXqv2bd9ktSNo7/v5OfW7Iovqq6/YXa/WCGf0TdB3OrFymYUdV+znzgzhLiniXLJf+
         Pp0w==
X-Gm-Message-State: AFqh2kp4OVtJT3NZIbFE1VylTO0+BTddkHZfzjpVHssRGJ9gfN5lMxXZ
        Da2twC3mnWoNZkc6oW1gY1yKDwKGfoYBtA==
X-Google-Smtp-Source: AMrXdXu0lbZRLpo4N23zsj1UOjubXghIf8iRFM9x/HTEIq8ondjfXrkjdUhzUolYL+g6kA+Z5G9k9Q==
X-Received: by 2002:a17:90a:faf:b0:219:2dce:29b5 with SMTP id 44-20020a17090a0faf00b002192dce29b5mr21438480pjz.29.1672025885355;
        Sun, 25 Dec 2022 19:38:05 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id s8-20020a17090a760800b00218e8a0d7f0sm7687222pjk.22.2022.12.25.19.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 19:38:04 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Dec 2022, #07; Mon, 26)
X-master-at: 8a4e8f6a67e7fc97048d4666eec38399b88e0e3b
X-next-at: 74172e4df8f68fd7c75fe67b318b8724dbc29762
Date:   Mon, 26 Dec 2022 12:38:04 +0900
Message-ID: <xmqqcz86n8bn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a future
release).  Commits prefixed with '-' are only in 'seen', and aren't
considered "accepted" at all.  A topic without enough support may be
discarded after a long period of no activity.

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
[New Topics]

* ab/avoid-losing-exit-codes-in-tests (2022-12-20) 6 commits
 - tests: don't lose misc "git" exit codes
 - tests: don't lose "git" exit codes in "! ( git ... | grep )"
 - tests: don't lose exit status with "test <op> $(git ...)"
 - tests: don't lose exit status with "(cd ...; test <op> $(git ...))"
 - t/lib-patch-mode.sh: fix ignored exit codes
 - auto-crlf tests: don't lose exit code in loops and outside tests

 Test clean-up.

 Will merge to 'next'?
 source: <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com>


* cw/ci-whitespace (2022-12-20) 3 commits
 - ci (check-whitespace): move to actions/checkout@v3
 - ci (check-whitespace): add links to job output
 - ci (check-whitespace): suggest fixes for errors

 CI updates.

 Will merge to 'next'?
 source: <pull.1444.v2.git.1671496548.gitgitgadget@gmail.com>


* dh/mingw-ownership-check-typofix (2022-12-20) 1 commit
 - mingw: fix typo in an error message from ownership check

 Error message typofix.

 Will merge to 'next'?
 source: <pull.1393.git.git.1671416810927.gitgitgadget@gmail.com>


* js/ci-disable-cmake-by-default (2022-12-20) 1 commit
 - ci: only run win+VS build & tests in Git for Windows' fork

 Stop running win+VS build by default.

 Will merge to 'next'?
 source: <pull.1445.git.1671461414191.gitgitgadget@gmail.com>


* sg/test-oid-wo-incomplete-line (2022-12-19) 1 commit
 - tests: make 'test_oid' print trailing newline

 Test helper updates.

 Will merge to 'next'?
 source: <20221218162905.3508164-1-szeder.dev@gmail.com>


* ab/bundle-wo-args (2022-12-25) 1 commit
  (merged to 'next' on 2022-12-26 at b086677fd0)
 + bundle: don't segfault on "git bundle <subcmd>"

 Fix to a small regression in 2.38 days.

 Will merge to 'master'.
 source: <patch-1.1-2319eb2ddbd-20221220T133941Z-avarab@gmail.com>


* ad/test-record-count-when-harness-is-in-use (2022-12-25) 1 commit
 - test-lib: allow storing counts with test harnesses

 Allow summary results from tests to be written to t/test-results
 directory even when a test harness like 'prove' is in use.

 Comments?
 source: <20221224225200.1027806-1-adam@dinwoodie.org>


* ps/fsync-refs-fix (2022-12-25) 1 commit
  (merged to 'next' on 2022-12-26 at 6358875b39)
 + refs: fix corruption by not correctly syncing packed-refs to disk

 Fix the sequence to fsync $GIT_DIR/packed-refs file that forgot to
 flush its output to the disk..

 Will merge to 'master'.
 source: <8c8ecf8e3718cbca049ee7a283edd7b7887e464e.1671547905.git.ps@pks.im>


* sk/win32-pthread-exit-fix (2022-12-25) 1 commit
  (merged to 'next' on 2022-12-26 at ebcb1fef4c)
 + win32: use _endthreadex to terminate threads, not ExitThread

 An API emulation fix.

 Will merge to 'master'.
 source: <pull.1414.v2.git.git.1671932510529.gitgitgadget@gmail.com>


* sk/win32-close-handle-upon-pthread-join (2022-12-26) 2 commits
 - win32: close handles of threads that have been joined
 - win32-pthread: prepare pthread.c for change by formatting

 source: <pull.1406.v12.git.git.1671932405.gitgitgadget@gmail.com>

--------------------------------------------------
[Graduated to 'master']

* ab/darwin-default-to-sha1dc (2022-12-16) 1 commit
  (merged to 'next' on 2022-12-16 at 31fb33b832)
 + Makefile: use sha1collisiondetection by default on OSX and Darwin

 Use the SHA1DC implementation on macOS, just like other platforms,
 by default.
 source: <patch-v2-1.1-3de7cdbd260-20221215T084129Z-avarab@gmail.com>


* ab/t4023-avoid-losing-exit-status-of-diff (2022-12-05) 1 commit
  (merged to 'next' on 2022-12-16 at 75c7a06930)
 + t4023: fix ignored exit codes of git

 Test fix.
 source: <patch-v2-3.8-c5feef1c808-20221202T000227Z-avarab@gmail.com>


* ab/t5314-avoid-losing-exit-status (2022-12-02) 1 commit
  (merged to 'next' on 2022-12-16 at 40f3acd249)
 + t5314: check exit code of "git"

 Test fix.
 source: <patch-v2-1.1-ca77a7249e6-20221128T141818Z-avarab@gmail.com>


* ab/t7600-avoid-losing-exit-status-of-git (2022-12-05) 1 commit
  (merged to 'next' on 2022-12-16 at ef89e4f2d1)
 + t7600: don't ignore "rev-parse" exit code in helper

 Test fix.
 source: <patch-v3-1.8-64dfec31fb3-20221202T114733Z-avarab@gmail.com>


* aw/complete-case-insensitive (2022-11-30) 2 commits
  (merged to 'next' on 2022-12-16 at 341974c2bb)
 + completion: add case-insensitive match of pseudorefs
 + completion: add optional ignore-case when matching refs

 Introduce a case insensitive mode to the Bash completion helpers.
 source: <pull.1374.v2.git.git.1668990419.gitgitgadget@gmail.com>


* jh/fsmonitor-darwin-modernize (2022-12-15) 1 commit
  (merged to 'next' on 2022-12-16 at 197e1f8c43)
 + fsmonitor: eliminate call to deprecated FSEventStream function

 Stop using deprecated macOS API in fsmonitor.
 source: <pull.1436.v2.git.1671045153981.gitgitgadget@gmail.com>


* jh/t7527-unflake-by-forcing-cookie (2022-12-02) 1 commit
  (merged to 'next' on 2022-12-16 at d64198c6c3)
 + fsmonitor: fix race seen in t7527

 Make fsmonitor more robust to avoid the flakiness seen in t7527.
 source: <pull.1437.git.1669937534944.gitgitgadget@gmail.com>


* jk/avoid-redef-system-functions (2022-12-05) 3 commits
  (merged to 'next' on 2022-12-16 at 55f7102dba)
 + Merge branch 'jk/avoid-redef-system-functions-2.30' into jk/avoid-redef-system-functions
 + Merge branch 'jk/avoid-redef-system-functions-2.30'
 + Merge branch 'jk/avoid-redef-system-functions-2.30' into maint
 (this branch uses jk/avoid-redef-system-functions-2.30.)

 The jk/avoid-redef-system-functions-2.30 topic pre-merged for more
 recent codebase.


* jk/avoid-redef-system-functions-2.30 (2022-12-05) 2 commits
  (merged to 'next' on 2022-12-16 at aa101dfc0c)
 + git-compat-util: undefine system names before redeclaring them
 + git-compat-util: avoid redefining system function names
 (this branch is used by jk/avoid-redef-system-functions.)

 Redefining system functions for a few functions did not follow our
 usual "implement git_foo() and #define foo(args) git_foo(args)"
 pattern, which has broken build for some folks.
 source: <Y4fH4rhcSztHwKvK@coredump.intra.peff.net>


* jk/ref-filter-error-reporting-fix (2022-12-15) 5 commits
  (merged to 'next' on 2022-12-16 at 8135d51462)
 + ref-filter: convert email atom parser to use err_bad_arg()
 + ref-filter: truncate atom names in error messages
 + ref-filter: factor out "unrecognized %(foo) arg" errors
 + ref-filter: factor out "%(foo) does not take arguments" errors
 + ref-filter: reject arguments to %(HEAD)

 Clean-ups in error messages produced by "git for-each-ref" and friends.
 source: <Y5n3S7cnD7s/AIRL@coredump.intra.peff.net>


* jk/server-supports-v2-cleanup (2022-12-13) 1 commit
  (merged to 'next' on 2022-12-16 at 9b995dc263)
 + server_supports_v2(): use a separate function for die_on_error

 Code clean-up.
 source: <Y5hZirNRGLQUZfOZ@coredump.intra.peff.net>


* jk/unused-post-2.39 (2022-12-13) 9 commits
  (merged to 'next' on 2022-12-16 at 4ce4a868e5)
 + userdiff: mark unused parameter in internal callback
 + list-objects-filter: mark unused parameters in virtual functions
 + diff: mark unused parameters in callbacks
 + xdiff: mark unused parameter in xdl_call_hunk_func()
 + xdiff: drop unused parameter in def_ff()
 + ws: drop unused parameter from ws_blank_line()
 + list-objects: drop process_gitlink() function
 + blob: drop unused parts of parse_blob_buffer()
 + ls-refs: use repository parameter to iterate refs

 Code clean-up around unused function parameters.
 source: <Y5hdvpbLpXySHFRz@coredump.intra.peff.net>


* js/t3920-shell-and-or-fix (2022-12-05) 1 commit
  (merged to 'next' on 2022-12-16 at 59536ed758)
 + t3920: don't ignore errors of more than one command with `|| true`
 (this branch is used by rs/t3920-crlf-eating-grep-fix.)

 Test fix.
 source: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>


* jt/http-fetch-trace2-report-name (2022-12-13) 1 commit
  (merged to 'next' on 2022-12-16 at b26e38cdb2)
 + http-fetch: invoke trace2_cmd_name()

 "git http-fetch" (which is rarely used) forgot to identify itself
 in the trace2 output.
 source: <20221212224630.2553391-1-jonathantanmy@google.com>


* pg/diff-stat-unmerged-regression-fix (2022-12-15) 1 commit
  (merged to 'next' on 2022-12-16 at 2a61376847)
 + diff: fix regression with --stat and unmerged file

 The output from "git diff --stat" on an unmerged path lost the
 terminating LF in Git 2.39, which has been corrected.
 source: <20221214174150.404821-1-pete@jpgrayson.net>


* rj/branch-copy-and-rename (2022-11-17) 1 commit
  (merged to 'next' on 2022-12-16 at b88fa41a8a)
 + branch: force-copy a branch to itself via @{-1} is a no-op

 Fix a pair of bugs in 'git branch'.
 source: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>


* rr/status-untracked-advice (2022-12-01) 1 commit
  (merged to 'next' on 2022-12-16 at bed7d84d07)
 + status: modernize git-status "slow untracked files" advice

 The advice message given by "git status" when it takes long time to
 enumerate untracked paths has been updated.
 source: <pull.1384.v9.git.1669769536707.gitgitgadget@gmail.com>


* rs/am-parse-options-cleanup (2022-12-13) 1 commit
  (merged to 'next' on 2022-12-16 at 9013ff2a19)
 + am: don't pass strvec to apply_parse_options()

 Code clean-up.
 source: <baf93e4a-7f05-857c-e551-09675496c03c@web.de>


* rs/clarify-error-in-write-loose-object (2022-12-14) 1 commit
  (merged to 'next' on 2022-12-16 at 8ef4588405)
 + object-file: inline write_buffer()

 Code clean-up.
 source: <94dff140-489c-40b2-7212-201ed3b7d008@web.de>


* rs/clear-commit-marks-cleanup (2022-12-13) 1 commit
  (merged to 'next' on 2022-12-16 at a9e52a7cef)
 + commit: skip already cleared parents in clear_commit_marks_1()

 Code clean-up.
 source: <7cf2ea1f-8dbf-5639-3874-86de391ae20a@web.de>


* rs/diff-parseopts (2022-12-02) 3 commits
  (merged to 'next' on 2022-12-16 at 6fdfd67cb9)
 + diff: remove parseopts member from struct diff_options
 + diff: use add_diff_options() in diff_opt_parse()
 + diff: factor out add_diff_options()

 The way the diff machinery prepares the options array for the
 parse_options API has been refactored to avoid resource leaks.
 source: <19325420-5630-87bb-0c2c-362151214b36@web.de>


* rs/plug-pattern-list-leak-in-lof (2022-12-02) 1 commit
  (merged to 'next' on 2022-12-16 at 5cc6d4165a)
 + list-objects-filter: plug pattern_list leak

 Leak fix.
 source: <b4361c3e-852b-e30c-f240-86c34bc9c474@web.de>


* rs/reflog-expiry-cleanup (2022-12-13) 1 commit
  (merged to 'next' on 2022-12-16 at 8165a625dd)
 + reflog: clear leftovers in reflog_expiry_cleanup()

 Code clean-up.
 source: <a53d4df3-4b2c-585a-e8ad-2a9b9017fb8c@web.de>


* rs/t3920-crlf-eating-grep-fix (2022-12-07) 1 commit
  (merged to 'next' on 2022-12-16 at 56ff27beaa)
 + t3920: support CR-eating grep
 (this branch uses js/t3920-shell-and-or-fix.)

 Test fix.
 source: <cbe88abc-c1fb-cb50-6057-47ff27f7a12d@web.de>


* rs/t4205-do-not-exit-in-test-script (2022-12-02) 1 commit
  (merged to 'next' on 2022-12-16 at 71b4de7729)
 + t4205: don't exit test script on failure

 Test fix.
 source: <c5b4d091-23c1-5a75-a255-99ec83973d8d@web.de>


* sg/help-autocorrect-config-fix (2022-12-13) 1 commit
  (merged to 'next' on 2022-12-16 at edcf99f34c)
 + help.c: fix autocorrect in work tree for bare repository

 The code to auto-correct a misspelt subcommand unnecessarily called
 into git_default_config() from the early config codepath, which was
 a no-no.  This has bee corrected.
 source: <pull.1373.v2.git.git.1667073374852.gitgitgadget@gmail.com>


* sk/remove-duplicate-includes (2022-12-15) 1 commit
  (merged to 'next' on 2022-12-16 at 846bc84e59)
 + git: remove duplicate includes

 Code clean-up.
 source: <pull.1394.git.git.1671036743272.gitgitgadget@gmail.com>


* sx/pthread-error-check-fix (2022-12-05) 1 commit
  (merged to 'next' on 2022-12-16 at 60848153fe)
 + maintenance: compare output of pthread functions for inequality with 0

 Correct pthread API usage.
 source: <pull.1389.git.git.1670000578395.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* ab/no-more-git-global-super-prefix (2022-12-26) 9 commits
 - read-tree: add "--super-prefix" option, eliminate global
 - submodule--helper: convert "{update,clone}" to their own "--super-prefix"
 - submodule--helper: convert "status" to its own "--super-prefix"
 - submodule--helper: convert "sync" to its own "--super-prefix"
 - submodule--helper: convert "foreach" to its own "--super-prefix"
 - submodule--helper: don't use global --super-prefix in "absorbgitdirs"
 - submodule.c & submodule--helper: pass along "super_prefix" param
 - read-tree + fetch tests: test failing "--super-prefix" interaction
 - submodule absorbgitdirs tests: add missing "Migrating git..." tests

 Stop using "git --super-prefix" and narrow the scope of its use to
 the submodule--helper.

 Will merge to 'next'.
 source: <cover-v5-0.9-00000000000-20221220T104519Z-avarab@gmail.com>


* cb/grep-fallback-failing-jit (2022-12-17) 1 commit
 - grep: fall back to interpreter mode if JIT fails

 In an environment where dynamically generated code is prohibited to
 run (e.g. SELinux), failure to JIT pcre patterns is expected.  Fall
 back to interpreted execution in such a case.

 Expecting a reroll.
 cf. <62a06c5b-9646-17f8-b4d5-39823d3cc25a@grsecurity.net>
 source: <20221216121557.30714-1-minipli@grsecurity.net>


* jc/spell-id-in-both-caps-in-message-id (2022-12-17) 1 commit
 - e-mail workflow: Message-ID is spelled with ID in both capital letters

 Consistently spell "Message-ID" as such, not "Message-Id".

 Comments?
 source: <xmqqsfhgnmqg.fsf@gitster.g>


* lk/line-range-parsing-fix (2022-12-20) 1 commit
  (merged to 'next' on 2022-12-26 at 216226a6e2)
 + line-range: fix infinite loop bug with '$' regex

 When given a pattern that matches an empty string at the end of a
 line, the code to parse the "git diff" line-ranges fell into an
 infinite loop, which has been corrected.

 Will merge to 'master'.
 source: <20221219224850.2703967-1-lars@oddbit.com>


* sa/git-var-sequence-editor (2022-12-18) 1 commit
  (merged to 'next' on 2022-12-20 at a5737674b6)
 + var: add GIT_SEQUENCE_EDITOR variable

 Just like "git var GIT_EDITOR" abstracts the complex logic to
 choose which editor gets used behind it, "git var" now give support
 to GIT_SEQUENCE_EDITOR.

 Will merge to 'master'.
 source: <pull.1424.v2.git.1671318599482.gitgitgadget@gmail.com>


* ss/pull-v-recurse-fix (2022-12-18) 1 commit
  (merged to 'next' on 2022-12-20 at 21f91dc75d)
 + submodule: accept -v for the update command

 "git pull -v --recurse-submodules" attempted to pass "-v" down to
 underlying "git submodule update", which did not understand the
 request and barfed, which has been corrected.

 Will merge to 'master'.
 source: <f805f2da-a7e1-9fde-cc0a-04a30f79c9af@cs-ware.de>


* ds/omit-trailing-hash-in-index (2022-12-17) 4 commits
 - features: feature.manyFiles implies fast index writes
 - test-lib-functions: add helper for trailing hash
 - read-cache: add index.skipHash config option
 - hashfile: allow skipping the hash function

 Introduce an optional configuration to allow the trailing hash that
 protects the index file from bit flipping.

 cf. <221216.86sfhf1gbc.gmgdl@evledraar.gmail.com>
 source: <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>


* ed/fsmonitor-inotify (2022-12-13) 6 commits
 - fsmonitor: update doc for Linux
 - fsmonitor: test updates
 - fsmonitor: enable fsmonitor for Linux
 - fsmonitor: implement filesystem change listener for Linux
 - fsmonitor: determine if filesystem is local or remote
 - fsmonitor: prepare to share code between Mac OS and Linux

 Bundled fsmonitor for Linux using inotify API.

 Needs review on the updated round.
 source: <pull.1352.v5.git.git.1670882286.gitgitgadget@gmail.com>


* es/t1509-root-fixes (2022-12-09) 3 commits
 - t1509: facilitate repeated script invocations
 - t1509: make "setup" test more robust
 - t1509: fix failing "root work tree" test due to owner-check

 source: <pull.1425.git.1668999621.gitgitgadget@gmail.com>


* jt/avoid-lazy-fetch-commits (2022-12-15) 4 commits
 - commit: don't lazy-fetch commits
 - object-file: emit corruption errors when detected
 - object-file: refactor map_loose_object_1()
 - object-file: remove OBJECT_INFO_IGNORE_LOOSE

 Even in a repository with promissor remote, it is useless to
 attempt to lazily attempt fetching an object that is expected to be
 commit, because no "filter" mode omits commit objects.  Take
 advantage of this assumption to fail fast on errors.

 Will merge to 'next'?
 source: <cover.1671045259.git.jonathantanmy@google.com>


* jx/t1301-updates (2022-11-30) 3 commits
 - t1301: do not change $CWD in "shared=all" test case
 - t1301: use test_when_finished for cleanup
 - t1301: fix wrong template dir for git-init

 Test updates.
 source: <20221128130323.8914-1-worldhello.net@gmail.com>


* km/send-email-with-v-reroll-count (2022-11-30) 2 commits
 - SQUASH???
 - send-email: relay '-v N' to format-patch

 "git send-email -v 3" used to be expanded to "git send-email
 --validate 3" when the user meant to pass them down to
 "format-patch", which has been corrected.

 Seems to break CI.
 source: <87edtp5uws.fsf@kyleam.com>


* so/diff-merges-more (2022-12-18) 5 commits
 - diff-merges: improve --diff-merges documentation
 - diff-merges: issue warning on lone '-m' option
 - diff-merges: support list of values for --diff-merges
 - diff-merges: implement log.diffMerges-m-imply-p config
 - diff-merges: implement [no-]hide option and log.diffMergesHide config

 Assorted updates to "--diff-merges=X" option.
 source: <20221217132955.108542-1-sorganov@gmail.com>


* ab/config-multi-and-nonbool (2022-11-27) 9 commits
 - for-each-repo: with bad config, don't conflate <path> and <cmd>
 - config API: add "string" version of *_value_multi(), fix segfaults
 - config API users: test for *_get_value_multi() segfaults
 - for-each-repo: error on bad --config
 - config API: have *_multi() return an "int" and take a "dest"
 - versioncmp.c: refactor config reading next commit
 - config tests: add "NULL" tests for *_get_value_multi()
 - config tests: cover blind spots in git_die_config() tests
 - for-each-repo tests: test bad --config keys

 Assorted config API updates.

 Waiting for review.
 source: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>


* sa/cat-file-mailmap--batch-check (2022-12-20) 2 commits
 - cat-file: add mailmap support to --batch-check option
 - cat-file: add mailmap support to -s option

 'cat-file' gains mailmap support for its '--batch-check' and '-s'
 options.

 Will merge to 'next'.
 cf. <221220.865ye6xlmo.gmgdl@evledraar.gmail.com>
 source: <20221220060113.51010-1-siddharthasthana31@gmail.com>


* ab/tag-object-type-errors (2022-11-22) 5 commits
 - tag: don't emit potentially incorrect "object is a X, not a Y"
 - tag: don't misreport type of tagged objects in errors
 - object tests: add test for unexpected objects in tags
 - object-file.c: free the "t.tag" in check_tag()
 - Merge branch 'jk/parse-object-type-mismatch' into ab/tag-object-type-errors

 Hardening checks around mismatched object types when one of those
 objects is a tag.

 Needs review.
 source: <cover-0.4-00000000000-20221118T113442Z-avarab@gmail.com>


* js/range-diff-mbox (2022-11-23) 1 commit
 - range-diff: support reading mbox files

 'git range-diff' gained support for reading either side from an .mbox
 file instead of a revision range.

 Expecting review responses.
 source: <pull.1420.v3.git.1669108102092.gitgitgadget@gmail.com>


* tr/am--no-verify (2022-12-01) 2 commits
 - SQUASH???
 - am: allow passing --no-verify flag

 Conditionally skip the pre-applypatch and applypatch-msg hooks when
 applying patches with 'git am'.

 Expecting a (hopefully final) reroll.
 source: <20221130172833.2662751-1-thierry.reding@gmail.com>


* ew/format-patch-mboxrd (2022-12-25) 1 commit
  (merged to 'next' on 2022-12-26 at bb6cc9e207)
 + format-patch: support format.mboxrd with --stdout

 "git format-patch" learned to honor format.mboxrd even when sending
 patches to the standard output stream,

 Will merge to 'master'.
 source: <20221222201619.M435985@dcvr>


* js/drop-mingw-test-cmp (2022-12-13) 1 commit
 - tests(mingw): avoid very slow `mingw_test_cmp`

 Use `git diff --no-index` as a test_cmp on Windows.

 Will merge to 'next'?
 source: <pull.1309.v5.git.1670339267.gitgitgadget@gmail.com>


* mc/switch-advice (2022-11-09) 1 commit
 - po: use `switch` over `checkout` in error message

 Use 'switch' instead of 'checkout' in an error message.

 Waiting for review response.
 source: <pull.1308.git.git.1668018620148.gitgitgadget@gmail.com>


* ja/worktree-orphan (2022-12-20) 4 commits
 - worktree add: add hint to use --orphan when bad ref
 - worktree add: add --orphan flag
 - worktree add: refactor opt exclusion tests
 - worktree add: include -B in usage docs

 'git worktree add' learned how to create a worktree based on an
 orphaned branch with `--orphan`.
 source: <20221220023637.29042-1-jacobabel@nullpo.dev>


* tb/ci-concurrency (2022-11-08) 1 commit
 - ci: avoid unnecessary builds

 Avoid unnecessary builds in CI, with settings configured in
 ci-config.

 Waiting for review.
 source: <ff172f1de982f6f79b598e4ac6d5b2964ca4a098.1667931937.git.me@ttaylorr.com>


* tl/notes--blankline (2022-11-09) 5 commits
 - notes.c: introduce "--no-blank-line" option
 - notes.c: provide tips when target and append note are both empty
 - notes.c: drop unreachable code in 'append_edit()'
 - notes.c: cleanup for "designated init" and "char ptr init"
 - notes.c: cleanup 'strbuf_grow' call in 'append_edit'

 'git notes append' was taught '--[no-]blank-line' to conditionally
 add a LF between a new and existing note.

 Waiting for review.
 source: <cover.1667980450.git.dyroneteng@gmail.com>


* ds/bundle-uri-4 (2022-12-25) 11 commits
  (merged to 'next' on 2022-12-26 at 6d7c21c44a)
 + clone: unbundle the advertised bundles
 + bundle-uri: download bundles from an advertised list
 + bundle-uri: allow relative URLs in bundle lists
 + strbuf: introduce strbuf_strip_file_from_path()
 + bundle-uri: serve bundle.* keys from config
 + bundle-uri client: add helper for testing server
 + transport: rename got_remote_heads
 + bundle-uri client: add boolean transfer.bundleURI setting
 + clone: request the 'bundle-uri' command when available
 + t: create test harness for 'bundle-uri' command
 + protocol v2: add server-side "bundle-uri" skeleton

 Bundle URIs part 4.

 Will merge to 'master'.
 source: <pull.1400.v4.git.1671722058.gitgitgadget@gmail.com>


* po/pretty-hard-trunc (2022-11-13) 1 commit
 - pretty-formats: add hard truncation, without ellipsis, options

 Add a new pretty format which truncates without ellipsis.

 Waiting for review.
 source: <20221112143616.1429-1-philipoakley@iee.email>


* cc/filtered-repack (2022-12-25) 3 commits
 - gc: add gc.repackFilter config option
 - repack: add --filter=<filter-spec> option
 - pack-objects: allow --filter without --stdout

 "git repack" learns to discard objects that ought to be retrievable
 again from the promissor remote.
 source: <20221221040446.2860985-1-christian.couder@gmail.com>


* mc/credential-helper-auth-headers (2022-12-13) 8 commits
 - t5556: add HTTP authentication tests
 - test-http-server: add simple authentication
 - test-http-server: pass Git requests to http-backend
 - test-http-server: add HTTP request parsing
 - test-http-server: add HTTP error response function
 - test-http-server: add stub HTTP server test helper
 - credential: add WWW-Authenticate header to cred requests
 - http: read HTTP WWW-Authenticate response headers

 Extending credential helper protocol.

 Waiting for review responses (or a reroll).
 cf. <1dc44716-2550-47de-e666-9972b102905d@github.com>
 source: <pull.1352.v4.git.1670880984.gitgitgadget@gmail.com>

--------------------------------------------------
[Discarded]

* pw/test-todo (2022-10-06) 3 commits
 . test_todo: allow [verbose] test as the command
 . test_todo: allow [!] grep as the command
 . tests: add test_todo() to mark known breakages

 RFC for test framework improvement.

 Needs review.
 source: <pull.1374.git.1665068476.gitgitgadget@gmail.com>


* cw/submodule-status-in-parallel (2022-11-08) 6 commits
 . diff-lib: parallelize run_diff_files for submodules
 . diff-lib: refactor match_stat_with_submodule
 . submodule: move status parsing into function
 . submodule: strbuf variable rename
 . run-command: add duplicate_output_fn to run_processes_parallel_opts
 . Merge branch 'ab/run-hook-api-cleanup' into cw/submodule-status-in-parallel

 Allow the internal "diff-files" engine to run "how has this
 submodule changed?" in parallel to speed up "git status".

 Waiting for review.
 source: <20221020232532.1128326-1-calvinwan@google.com>


* es/doc-creation-factor-fix (2022-07-28) 2 commits
 . range-diff: clarify --creation-factor=<factor>
 . format-patch: clarify --creation-factor=<factor>

 Expecting a reroll by somebody more familiar with the logic
 cf. <xmqqo7wfix7p.fsf@gitster.g>
 source: <7229p500-p2r4-on87-6802-8o90s36rr3s4@tzk.qr>


* ds/bundle-uri-4-fixup (2022-12-13) 3 commits
 . bundle-uri: remove GIT_TEST_BUNDLE_URI env variable
 . bundle-uri: advertise based on repo config
 . bundle-uri: drop unused 'uri' parameter

 Incremental fixes on ds/bundle-uri-4 topic.

 Discarded.
 The base topic has been updated to make these "oops" fixes unneeded.
 source: <pull.1443.git.1670866407.gitgitgadget@gmail.com>
