Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC16C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 12:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiLAMXr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 07:23:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiLAMXq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 07:23:46 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87363FB81
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 04:23:42 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so1877400pjm.2
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 04:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wsMonC869T6+c7wpc4OpYAx3n01kchX+d9pICKMLKKg=;
        b=W7HvR7Uy6zdvKRkKfh46dBy4lS7Cak0PP+5GGhg0Z7JjyC6U4RJZKUUqOVao8rf1zi
         d5gHV6eqiLyDUBu1kU1we1QKGfS0+lQ+aOdmE8qTkfjrvt6T+SAddbVLCr3+5xxnsS4D
         9fg/rbjATCQkKlWqrTKr0S4QOtk+RSX9vEhF3DbKE6IrEMNOaFg5plkdJu/CEK7crPt1
         wzJGDOihLjZpFidDMmZIW7buic51KNJ9sNRgNpdLU0mr2i/HseTGg8mTBd6t3+xtPCk2
         laMuh7VAxzaUXLQjFxKtKOL/D3NgAXHhvcpftvUHSO2GeVcod725Ln5FtWPOX4LpHdqY
         uAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsMonC869T6+c7wpc4OpYAx3n01kchX+d9pICKMLKKg=;
        b=DCcb49yCttvP/kk9zxJVy6TqhOt1R2tIinhEoM0LfYiTHQEj0EIgTiXtQ78CdUh+PL
         vX3uhxg5Qh8ENGYCpjeBMLH3Ik0R4+XC31VLrp7buWYXErL3/C8txtbpSV1D9b6UWFEW
         ed6L+JByfcCBUZePejtsiIMCKilRRK3SS5WHBiEDgwMNMemS35KdsmvB0xyhtz9M0Y+l
         wqh2Jxc+wRzBA0WUX46fBatSWyZm2iJlOey0ZakFLD3p8uoWUFeEwRYyOfzsFFL9jji1
         yJ9kV3Lq47JnBtCSkIsVaHEUxUcLNIaqhxXMiKr7mWNrpAk0GoXPU8ajEz59GWn4NgB1
         wi9w==
X-Gm-Message-State: ANoB5pljSrxDR8bAOl14rc/BEsZo6opqRr3j5Sbc223c9ZcH4H3Sygu6
        AR0kPcSI0YrYr1kJvZbRVLE/s4U4qCNe2Q==
X-Google-Smtp-Source: AA0mqf6P2wvYCguV5eBmvzqWvfwrrX76RzB1A6YfNTAtdqIdIGb9pQ1T+hqtaJq/UaH3soGddvAvFw==
X-Received: by 2002:a17:90b:3012:b0:219:63d9:516c with SMTP id hg18-20020a17090b301200b0021963d9516cmr8411245pjb.108.1669897421445;
        Thu, 01 Dec 2022 04:23:41 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id je10-20020a170903264a00b00186abb95bfdsm3515784plb.25.2022.12.01.04.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 04:23:40 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Dec 2022, #01; Thu, 1)
X-master-at: 805265fcf7a737664a8321aaf4a0587b78435184
X-next-at: 54fd8350bdd496cc00f47dcf638aba6a72732ffa
Date:   Thu, 01 Dec 2022 21:23:40 +0900
Message-ID: <xmqqr0xjs46r.fsf@gitster.g>
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

The first release candidate has been tagged.

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

* jk/avoid-redef-system-functions (2022-12-01) 2 commits
  (merged to 'next' on 2022-12-01 at 7b6131f09f)
 + Merge branch 'jk/avoid-redef-system-functions-2.30'
 + Merge branch 'jk/avoid-redef-system-functions-2.30' into maint
 (this branch uses jk/avoid-redef-system-functions-2.30.)

 The jk/avoid-redef-system-functions-2.30 topic pre-merged for more
 recent codebase.

 Will cook in 'next'.


* jk/avoid-redef-system-functions-2.30 (2022-12-01) 1 commit
  (merged to 'next' on 2022-12-01 at b52a884362)
 + git-compat-util: avoid redefining system function names
 (this branch is used by jk/avoid-redef-system-functions.)

 Redefining system functions for a few functions did not follow our
 usual "implement git_foo() and #define foo(args) git_foo(args)"
 pattern, which has broken build for some folks.

 Will cook in 'next'.
 source: <Y4fH4rhcSztHwKvK@coredump.intra.peff.net>


* jt/avoid-lazy-fetch-commits (2022-12-01) 4 commits
 . commit: don't lazy-fetch commits
 . object-file: refactor replace object lookup
 . object-file: refactor corrupt object diagnosis
 . object-file: reread object with exact same args

 Even in a repository with promissor remote, it is useless to
 attempt to lazily attempt fetching an object that is expected to be
 commit, because no "filter" mode omits commit objects.  Take
 advantage of this assumption to fail fast on errors.

 Seems to break CI (win test (7)).
 cf. https://github.com/git/git/actions/runs/3591107183/jobs/6045374690
 source: <cover.1669839849.git.jonathantanmy@google.com>


* rs/diff-parseopts (2022-12-01) 4 commits
 - SQUASH???
 - diff: remove parseopts member of struct diff_options
 - diff: let prep_parse_options() return parseopt array
 - diff: factor out add_diff_options()

 The way the diff machinery prepares the options array for the
 parse_options API has been refactored to avoid resource leaks.

 Will merge to 'next'?
 source: <0620b4a6-b80a-d8a0-5a35-857b9fe0c986@web.de>

--------------------------------------------------
[Graduated to 'master']

* ab/fewer-the-index-macros (2022-12-01) 1 commit
  (merged to 'next' on 2022-12-01 at 21b212faed)
 + cocci: avoid "should ... be a metavariable" warnings

 Squelch warnings from Coccinelle
 source: <patch-1.1-31af153702e-20221130T082521Z-avarab@gmail.com>


* ab/gnumake-4.4-fix (2022-12-01) 1 commit
  (merged to 'next' on 2022-12-01 at c4d7fa882b)
 + Makefiles: change search through $(MAKEFLAGS) for GNU make 4.4

 Adjust our Makefiles for GNUmake 4.4
 source: <patch-v3-1.1-432518b2dd7-20221130T081835Z-avarab@gmail.com>


* ps/gnumake-4.4-fix (2022-11-28) 1 commit
  (merged to 'next' on 2022-11-29 at 1151bc06fc)
 + Makefile: avoid multiple patterns when recipes generate one file

 Adjust Makefile for GNU make 4.4
 source: <20221127224251.2508200-2-psmith@gnu.org>

--------------------------------------------------
[Stalled]

* ms/sendemail-validate-headers (2022-11-11) 1 commit
 . Expose header information to git-send-email's sendemail-validate hook

 Expecting a reroll.
 Appears to break t9001 completely?
 source: <20221111194223.644845-2-michael.strawbridge@amd.com>


* hl/archive-recursive (2022-10-19) 10 commits
 . fixup! archive: add tests for git archive --recurse-submodules
 . archive: add tests for git archive --recurse-submodules
 . archive: add --recurse-submodules to git-archive command
 . archive: remove global repository from archive_args
 . archive: pass repo objects to write_archive handlers
 . tree: add repository parameter to read_tree_fn_t
 . tree: handle submodule case for read_tree_at properly
 . tree: increase test coverage for tree.c
 . tree: update cases to use repo_ tree methods
 . tree: do not use the_repository for tree traversal methods.

 "git archive" has been taught "--recurse-submodules" option to
 create a tarball that includes contents from submodules.

 Expecting a reroll.
 Seems to break win+VS test(8).
 cf. https://github.com/git/git/actions/runs/3293333066 whose only
 difference from https://github.com/git/git/actions/runs/3293553109
 is the inclusion of this topic.
 source: <pull.1359.v3.git.git.1665973401.gitgitgadget@gmail.com>


* pw/test-todo (2022-10-06) 3 commits
 . test_todo: allow [verbose] test as the command
 . test_todo: allow [!] grep as the command
 . tests: add test_todo() to mark known breakages

 RFC for test framework improvement.

 Needs review.
 source: <pull.1374.git.1665068476.gitgitgadget@gmail.com>


* cw/submodule-status-in-parallel (2022-11-08) 6 commits
 - diff-lib: parallelize run_diff_files for submodules
 - diff-lib: refactor match_stat_with_submodule
 - submodule: move status parsing into function
 - submodule: strbuf variable rename
 - run-command: add duplicate_output_fn to run_processes_parallel_opts
 - Merge branch 'ab/run-hook-api-cleanup' into cw/submodule-status-in-parallel

 Allow the internal "diff-files" engine to run "how has this
 submodule changed?" in parallel to speed up "git status".

 Waiting for review.
 source: <20221020232532.1128326-1-calvinwan@google.com>


* js/bisect-in-c (2022-08-30) 17 commits
 . bisect: no longer try to clean up left-over `.git/head-name` files
 . bisect: remove Cogito-related code
 . Turn `git bisect` into a full built-in
 . bisect: move even the command-line parsing to `bisect--helper`
 . bisect--helper: make `state` optional
 . bisect--helper: calling `bisect_state()` without an argument is a bug
 . bisect: avoid double-quoting when printing the failed command
 . bisect run: fix the error message
 . bisect: verify that a bogus option won't try to start a bisection
 . bisect--helper: migrate to OPT_SUBCOMMAND()
 . bisect--helper: make the order consistently `argc, argv`
 . bisect--helper: make `terms` an explicit singleton
 . bisect--helper: simplify exit code computation
 . bisect--helper: really retire `--bisect-autostart`
 . bisect--helper: really retire --bisect-next-check
 . bisect--helper: retire the --no-log option
 . Merge branch 'sg/parse-options-subcommand' into js/bisect-in-c

 Final bits of "git bisect.sh" have been rewritten in C.

 Temporarily ejected from 'seen'. Waiting for a response on how this
 topic interacts with 'dd/git-bisect-builtin'.
 cf. <xmqqv8pr8903.fsf@gitster.g>
 source: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>


* od/ci-use-checkout-v3-when-applicable (2022-10-10) 2 commits
 . ci(main): linux32 uses actions/checkout@v2
 . ci(main): upgrade actions/checkout to v3

 Attempt to update GitHub CI to use actions/checkout@v3

 Expecting a reroll.
 Seems to break the CI completely.
 source: <pull.1354.git.git.1665388136.gitgitgadget@gmail.com>


* ed/fsmonitor-inotify (2022-11-25) 6 commits
 - fsmonitor: update doc for Linux
 - fsmonitor: test updates
 - fsmonitor: enable fsmonitor for Linux
 - fsmonitor: implement filesystem change listener for Linux
 - fsmonitor: determine if filesystem is local or remote
 - fsmonitor: prepare to share code between Mac OS and Linux

 Bundled fsmonitor for Linux using inotify API.

 Needs review on the updated round.
 source: <pull.1352.v4.git.git.1669230044.gitgitgadget@gmail.com>


* ag/merge-strategies-in-c (2022-08-10) 14 commits
 . sequencer: use the "octopus" strategy without forking
 . sequencer: use the "resolve" strategy without forking
 . merge: use the "octopus" strategy without forking
 . merge: use the "resolve" strategy without forking
 . merge-octopus: rewrite in C
 . merge-recursive: move better_branch_name() to merge.c
 . merge-resolve: rewrite in C
 . merge-one-file: rewrite in C
 . update-index: move add_cacheinfo() to read-cache.c
 . merge-index: add a new way to invoke `git-merge-one-file'
 . merge-index: drop the index
 . merge-index: libify merge_one_path() and merge_all()
 . t6060: add tests for removed files
 . t6060: modify multiple files to expose a possible issue with merge-index

 An attempt to rewrite remaining merge strategies from shell to C.

 Needs more work.
 At the minimum, we should lose 11/14 and possibly 08/14.
 cf. <xmqq7d36vfur.fsf@gitster.g>
 source: <20220809185429.20098-1-alban.gruin@gmail.com>


* es/doc-creation-factor-fix (2022-07-28) 2 commits
 . range-diff: clarify --creation-factor=<factor>
 . format-patch: clarify --creation-factor=<factor>

 Expecting a reroll by somebody more familiar with the logic
 cf. <xmqqo7wfix7p.fsf@gitster.g>
 source: <7229p500-p2r4-on87-6802-8o90s36rr3s4@tzk.qr>


* cw/remote-object-info (2022-08-13) 7 commits
 . SQUASH???
 . cat-file: add remote-object-info to batch-command
 . transport: add client support for object-info
 . serve: advertise object-info feature
 . protocol-caps: initialization bug fix
 . fetch-pack: move fetch initialization
 . fetch-pack: refactor packet writing

 A client component to talk with the object-info endpoint.

 Expecting a reroll.
 Under SANITIZE=address, t1006-cat-file.sh finds a breakage.
 cf. <20220728230210.2952731-1-calvinwan@google.com>
 cf. <CAFySSZDvgwbbHCHfyuaqX3tKsr-GjJ9iihygg6rNNe46Ys7_EA@mail.gmail.com>
 source: <20220728230210.2952731-1-calvinwan@google.com>

--------------------------------------------------
[Cooking]

* sa/git-var-empty (2022-11-27) 2 commits
  (merged to 'next' on 2022-12-01 at 3b81dcb382)
 + var: allow GIT_EDITOR to return null
 + var: do not print usage() with a correct invocation

 "git var UNKNOWN_VARIABLE" and "git var VARIABLE" with the variable
 given an empty value used to behave identically.  Now the latter
 just gives an empty output, while the former still gives an error
 message.

 Will cook in 'next'.
 source: <pull.1434.v3.git.1669472277.gitgitgadget@gmail.com>


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


* so/diff-merges-more (2022-11-30) 6 commits
 . SQUASH??? cocci fix
 . diff-merges: issue warning on lone '-m' option
 . diff-merges: support list of values for --diff-merges
 . diff-merges: implement log.diffMergesForce config
 . diff-merges: implement log.diffMerges-m-imply-p config
 . diff-merges: implement [no-]hide option and log.diffMergesHide config

 Assorted updates to "--diff-merges=X" option.

 Seems to break CI.
 Cocci complains about "if (func_ptr != NULL)"
 cf. https://github.com/git/git/actions/runs/3583592108/jobs/6029213624
 source: <20221127093721.31012-1-sorganov@gmail.com>


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


* yn/git-jump-emacs (2022-11-27) 3 commits
  (merged to 'next' on 2022-11-29 at d0960938a0)
 + git-jump: invoke emacs/emacsclient
 + git-jump: move valid-mode check earlier
 + git-jump: add an optional argument '--stdout'

 "git jump" (in contrib/) learned to present the "quickfix list" to
 its standard output (instead of letting it consumed by the editor
 it invokes), and learned to also drive emacs/emacsclient.

 Will cook in 'next'.
 source: <pull.1423.v8.git.1669511933.gitgitgadget@gmail.com>


* sa/cat-file-mailmap--batch-check (2022-11-21) 2 commits
 . cat-file: add mailmap support to --batch-check option
 . cat-file: add mailmap support to -s option

 'cat-file' gains mailmap support for its '--batch-check' and '-s'
 options.

 Seems to break CI.
 test broken on osx due to "wc -c" padding its output
 cf. https://github.com/git/git/actions/runs/3581605069/jobs/6024866010#step:4:1860
 source: <20221120074852.121346-1-siddharthasthana31@gmail.com>


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


* rj/branch-copy-and-rename (2022-11-17) 2 commits
 - branch: clear target branch configuration before copying or renaming
 - branch: force-copy a branch to itself via @{-1} is a no-op

 Fix a pair of bugs in 'git branch'.

 Waiting for review discussion to settle.
 source: <f0b2d46c-2e9c-2630-2870-8ed550dd1606@gmail.com>


* tl/ls-tree--pattern (2022-11-17) 6 commits
 . ls-tree: introduce '--pattern' option
 . ls-tree: introduce 'match_pattern()' function
 . ls-tree: improving cohension in the print code
 . ls-tree: optimize params of 'show_tree_common_default_long()'
 . t3104: remove shift code in 'test_ls_tree_format'
 . ls-tree: cleanup the redundant SPACE

 A synonym for "ls-tree | grep <pattern>", "ls-tree
 --pattern=<pattern>" was introduced.

 Waiting for review response, but leaning negative.
 Seems to break CI.
 test broken with SHA256 due to hardcoded hexadecimal constants
 cf. https://github.com/git/git/actions/runs/3581947576/jobs/6025603775#step:4:1846
 source: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com>


* tr/am--no-verify (2022-12-01) 2 commits
 - SQUASH???
 - am: allow passing --no-verify flag

 Conditionally skip the pre-applypatch and applypatch-msg hooks when
 applying patches with 'git am'.

 Expecting a (hopefully final) reroll.
 source: <20221130172833.2662751-1-thierry.reding@gmail.com>


* ab/remove--super-prefix (2022-11-21) 12 commits
 . fetch: rename "--submodule-prefix" to "--super-prefix"
 . read-tree: add "--super-prefix" option, eliminate global
 . submodule--helper: convert "{update,clone}" to their own "--super-prefix"
 . submodule--helper: convert "status" to its own "--super-prefix"
 . submodule--helper: convert "sync" to its own "--super-prefix"
 . submodule--helper: convert "foreach" to its own "--super-prefix"
 . submodule--helper: don't use global --super-prefix in "absorbgitdirs"
 . submodule.c & submodule--helper: pass along "super_prefix" param
 . read-tree + fetch tests: test failing "--super-prefix" interaction
 . Merge branch 'ab/submodule-no-abspath' into ab/remove--super-prefix
  (merged to 'next' on 2022-11-18 at 34d0accc7b)
 + submodule--helper absorbgitdirs: no abspaths in "Migrating git..."
 . Merge branch 'ab/submodule-helper-prep-only' into ab/remove--super-prefix

 Remove the top-level `--super-prefix` option.
 source: <cover-v3-0.9-00000000000-20221119T122853Z-avarab@gmail.com>


* ab/submodule-no-abspath (2022-11-23) 2 commits
  (merged to 'next' on 2022-11-23 at 97b6096e7c)
 + submodule absorbgitdirs: use relative <from> and <to> paths
  (merged to 'next' on 2022-11-18 at 34d0accc7b)
 + submodule--helper absorbgitdirs: no abspaths in "Migrating git..."

 Remove an absolute path in the "Migrating git directory" message.

 Will cook in 'next', but leaning negative.
 source: <patch-1.1-34b54fdd9bb-20221109T020347Z-avarab@gmail.com>
 source: <patch-1.1-065be1da895-20221122T224306Z-avarab@gmail.com>


* ew/format-patch-mboxrd (2022-11-14) 1 commit
 - format-patch: add --mboxrd alias for --pretty=mboxrd

 Teach `format-patch` a convenient alias for `--pretty=mboxrd`.

 Waiting for discussion to settle.
 source: <20221114094114.18986-1-e@80x24.org>


* js/drop-mingw-test-cmp (2022-11-14) 2 commits
 - tests(mingw): avoid very slow `mingw_test_cmp`
 - t0021: use Windows-friendly `pwd`

 Use `git diff --no-index` as a test_cmp on Windows.

 Waiting for review response.
 source: <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>


* mc/switch-advice (2022-11-09) 1 commit
 - po: use `switch` over `checkout` in error message

 Use 'switch' instead of 'checkout' in an error message.

 Waiting for review response.
 source: <pull.1308.git.git.1668018620148.gitgitgadget@gmail.com>


* rs/multi-filter-args (2022-11-30) 5 commits
  (merged to 'next' on 2022-12-01 at 5848d16bb6)
 + list-objects-filter: remove OPT_PARSE_LIST_OBJECTS_FILTER_INIT()
 + pack-objects: simplify --filter handling
 + pack-objects: fix handling of multiple --filter options
 + t5317: demonstrate failure to handle multiple --filter options
 + t5317: stop losing return codes of git ls-files

 Fix a bug where `pack-objects` would not respect multiple `--filter`
 arguments when invoked directly.

 Will cook in 'next'.
 source: <c2d3e7a3-599f-dae5-8dde-dc969df39f02@web.de>


* ab/various-leak-fixes (2022-11-21) 16 commits
  (merged to 'next' on 2022-11-21 at eff484a27c)
 + built-ins: use free() not UNLEAK() if trivial, rm dead code
 + revert: fix parse_options_concat() leak
 + cherry-pick: free "struct replay_opts" members
 + rebase: don't leak on "--abort"
 + connected.c: free the "struct packed_git"
 + sequencer.c: fix "opts->strategy" leak in read_strategy_opts()
 + ls-files: fix a --with-tree memory leak
 + revision API: call graph_clear() in release_revisions()
 + unpack-file: fix ancient leak in create_temp_file()
 + built-ins & libs & helpers: add/move destructors, fix leaks
 + dir.c: free "ident" and "exclude_per_dir" in "struct untracked_cache"
 + read-cache.c: clear and free "sparse_checkout_patterns"
 + commit: discard partial cache before (re-)reading it
 + {reset,merge}: call discard_index() before returning
 + tests: mark tests as passing with SANITIZE=leak
 + Merge branch 'pw/rebase-no-reflog-action' into ab/various-leak-fixes

 Various leak fixes.

 Will cook in 'next'.
 source: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>


* aw/complete-case-insensitive (2022-11-30) 2 commits
 - completion: add case-insensitive match of pseudorefs
 - completion: add optional ignore-case when matching refs

 Introduce a case insensitive mode to the Bash completion helpers.

 Will cook in 'next'.
 source: <pull.1374.v2.git.git.1668990419.gitgitgadget@gmail.com>


* dd/git-bisect-builtin (2022-11-15) 13 commits
  (merged to 'next' on 2022-11-15 at e16e754058)
 + bisect; remove unused "git-bisect.sh" and ".gitignore" entry
  (merged to 'next' on 2022-11-14 at fc304fb52f)
 + Turn `git bisect` into a full built-in
 + bisect--helper: log: allow arbitrary number of arguments
 + bisect--helper: handle states directly
 + bisect--helper: emit usage for "git bisect"
 + bisect test: test exit codes on bad usage
 + bisect--helper: identify as bisect when report error
 + bisect-run: verify_good: account for non-negative exit status
 + bisect run: keep some of the post-v2.30.0 output
 + bisect: fix output regressions in v2.30.0
 + bisect: refactor bisect_run() to match CodingGuidelines
 + bisect tests: test for v2.30.0 "bisect run" regressions
 + Merge branch 'dd/bisect-helper-subcommand' into dd/git-bisect-builtin

 `git bisect` becomes a builtin.

 Will cook in 'next'.
 source: <cover.1668097962.git.congdanhqx@gmail.com>


* ds/packed-refs-v2 (2022-11-07) 30 commits
 - refs: skip hashing when writing packed-refs v2
 - p1401: create performance test for ref operations
 - ci: run GIT_TEST_PACKED_REFS_VERSION=2 in some builds
 - t*: skip packed-refs v2 over http tests
 - t3210: require packed-refs v1 for some tests
 - t5502: add PACKED_REFS_V1 prerequisite
 - t5312: allow packed-refs v2 format
 - t1409: test with packed-refs v2
 - packed-backend: create GIT_TEST_PACKED_REFS_VERSION
 - packed-refs: write prefix chunks
 - packed-refs: read optional prefix chunks
 - packed-refs: read file format v2
 - packed-refs: write file format version 2
 - packed-backend: create shell of v2 writes
 - config: add config values for packed-refs v2
 - packed-backend: create abstraction for writing refs
 - packed-backend: extract iterator/updates merge
 - packed-backend: extract add_write_error()
 - refs: extract packfile format to new file
 - chunk-format: parse trailing table of contents
 - chunk-format: allow trailing table of contents
 - chunk-format: store chunk offset during write
 - chunk-format: document trailing table of contents
 - chunk-format: number of chunks is optional
 - refs: allow loose files without packed-refs
 - repository: wire ref extensions to ref backends
 - config: fix multi-level bulleted list
 - extensions: add refFormat extension
 - read-cache: add index.computeHash config option
 - hashfile: allow skipping the hash function

 Waiting for review.
 source: <pull.1408.git.1667846164.gitgitgadget@gmail.com>


* ja/worktree-orphan (2022-11-10) 2 commits
 - worktree add: add --orphan flag
 - worktree add: Include -B in usage docs

 'git worktree add' learned how to create a worktree based on an
 orphaned branch with `--orphan`.

 Expecting another round?
 source: <20221110233137.10414-1-jacobabel@nullpo.dev>


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


* ds/bundle-uri-4 (2022-11-16) 9 commits
 . clone: unbundle the advertised bundles
 . bundle-uri: download bundles from an advertised list
 . bundle-uri: allow relative URLs in bundle lists
 . strbuf: introduce strbuf_strip_file_from_path()
 . bundle-uri client: add boolean transfer.bundleURI setting
 . bundle-uri: serve bundle.* keys from config
 . bundle-uri client: add helper for testing server
 . bundle-uri client: add minimal NOOP client
 . protocol v2: add server-side "bundle-uri" skeleton

 Bundle URIs part 4.

 Waiting for review.
 Seems to break CI.
 test broken with linux-TEST_vars
 cf. https://github.com/git/git/actions/runs/3583689825/jobs/6029429974
 source: <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>


* tl/pack-bitmap-absolute-paths (2022-11-29) 4 commits
  (merged to 'next' on 2022-11-30 at cb5d17ee40)
 + pack-bitmap.c: trace bitmap ignore logs when midx-bitmap is found
 + pack-bitmap.c: break out of the bitmap loop early if not tracing
  (merged to 'next' on 2022-11-14 at 34eb0ea05a)
 + pack-bitmap.c: avoid exposing absolute paths
 + pack-bitmap.c: remove unnecessary "open_pack_index()" calls

 The pack-bitmap machinery is taught to log the paths of redundant
 bitmap(s) to trace2 instead of stderr.

 Will cook in 'next'.
 source: <cover.1669644101.git.dyroneteng@gmail.com>


* ab/cmake-nix-and-ci (2022-11-04) 14 commits
  (merged to 'next' on 2022-11-08 at 6ef4e93b36)
 + CI: add a "linux-cmake-test" to run cmake & ctest on linux
 + cmake: copy over git-p4.py for t983[56] perforce test
 + cmake: only look for "sh" in "C:/Program Files" on Windows
 + cmake: increase test timeout on Windows only
 + cmake: support GIT_TEST_OPTS, abstract away WIN32 defaults
 + Makefile + cmake: use environment, not GIT-BUILD-DIR
 + test-lib.sh: support a "GIT_TEST_BUILD_DIR"
 + cmake: set "USE_LIBPCRE2" in "GIT-BUILD-OPTIONS" for test-lib.sh
 + cmake & test-lib.sh: add a $GIT_SOURCE_DIR variable
 + cmake: chmod +x the bin-wrappers/* & SCRIPT_{SH,PERL} & git-p4
 + cmake: don't copy chainlint.pl to build directory
 + cmake: update instructions for portable CMakeLists.txt
 + cmake: use "-S" and "-B" to specify source and build directories
 + cmake: don't invoke msgfmt with --statistics

 Fix assorted issues with CTest on *nix machines.

 Will cook in 'next'.
 source: <cover-v4-00.14-00000000000-20221103T160255Z-avarab@gmail.com>


* ab/make-bin-wrappers (2022-10-31) 4 commits
 . Makefile: simplify $(test_bindir_programs) rule by splitting it up
 . Makefile: rename "test_bindir_programs" variable, pre-declare
 . Makefile: define "TEST_{PROGRAM,OBJS}" variables earlier
 . Makefile: factor sed-powered '#!/bin/sh' munging into a variable

 Resolve issues with the bin-wrappers/% rules where "make
 bin-wrappers/git" would generate the script but not "git" itself.

 Waiting for review discussion to settle, but leaning negative.
 source: <cover-v3-0.4-00000000000-20221031T222249Z-avarab@gmail.com>


* kz/merge-tree-merge-base (2022-11-25) 3 commits
  (merged to 'next' on 2022-11-25 at 298ca8e2e8)
 + docs: fix description of the `--merge-base` option
  (merged to 'next' on 2022-11-14 at 76d48ae21f)
 + merge-tree.c: allow specifying the merge-base when --stdin is passed
 + merge-tree.c: add --merge-base=<commit> option

 "merge-tree" learns a new `--merge-base` option.

 Will cook in 'next'.
 source: <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
 source: <c21466d1db0e7f7fcd7308b61aa1e3cd4e3d67c4.1669261026.git.gitgitgadget@gmail.com>


* po/pretty-hard-trunc (2022-11-13) 1 commit
 - pretty-formats: add hard truncation, without ellipsis, options

 Add a new pretty format which truncates without ellipsis.

 Waiting for review.
 source: <20221112143616.1429-1-philipoakley@iee.email>


* rr/status-untracked-advice (2022-12-01) 1 commit
 - status: modernize git-status "slow untracked files" advice

 The advice message given by "git status" when it takes long time to
 enumerate untracked paths has been updated.

 Will merge to 'next'.
 source: <pull.1384.v9.git.1669769536707.gitgitgadget@gmail.com>


* cc/filtered-repack (2022-11-23) 2 commits
 - repack: add --filter=<filter-spec> option
 - pack-objects: allow --filter without --stdout

 "git repack" learns to discard objects that ought to be retrievable
 again from the promissor remote.

 Needs review.
 Seems to break CI.
 cf. https://github.com/git/git/actions/runs/3560918726
 source: <20221122175150.366828-1-christian.couder@gmail.com>


* mc/credential-helper-auth-headers (2022-11-02) 11 commits
 . t5556: add HTTP authentication tests
 . test-http-server: add simple authentication
 . test-http-server: pass Git requests to http-backend
 . test-http-server: add HTTP request parsing
 . test-http-server: add HTTP error response function
 . test-http-server: add stub HTTP server test helper
 . http: set specific auth scheme depending on credential
 . http: move proactive auth to first slot creation
 . http: store all request headers on active_request_slot
 . credential: add WWW-Authenticate header to cred requests
 . http: read HTTP WWW-Authenticate response headers

 Extending credential helper protocol.

 Needs review.
 Seems to break CI.
 cf. https://github.com/git/git/actions/runs/3580969920
 source: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>

--------------------------------------------------
[Discarded]

* gc/submodule-clone-update-with-branches (2022-10-30) 8 commits
 . clone, submodule update: create and check out branches
 . submodule--helper: remove update_data.suboid
 . submodule update: refactor update targets
 . submodule: return target of submodule symref
 . t5617: drop references to remote-tracking branches
 . submodule--helper clone: create named branch
 . repo-settings: add submodule_propagate_branches
 . clone: teach --detach option

 "git clone --recurse-submodules" and "git submodule update" learns
 to honor the "propagete branches" option.

 Will discard for now.
 cf. <xmqqedtl14xr.fsf@gitster.g>
 source: <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com>
