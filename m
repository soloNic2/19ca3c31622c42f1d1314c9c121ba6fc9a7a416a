Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB66BC25B08
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 02:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242730AbiHRCXf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 22:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240178AbiHRCXe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 22:23:34 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883DC43E65
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 19:23:30 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 197BD1B957B;
        Wed, 17 Aug 2022 22:23:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=/
        2y4rwk7BID7RD/j/aUf+K/3LhLD1mYjuNhkoNMqGNg=; b=Ehilx2jFRUavoOp1T
        wlvKCwQKD51ju7fL645crkU8gUuAYmJkqp8RxOf6L1CH0Kf1jW4+tu755dDeh0GG
        uCTFaOuldAnxVkCYcN2kIzt9fK7q6+niBFIcmZ1+lUEGSpFJRwfpcTZGsHQSfWPo
        IeCELf9OZsS530eYZz4RjgdwwU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 11C1C1B957A;
        Wed, 17 Aug 2022 22:23:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A7D691B9578;
        Wed, 17 Aug 2022 22:23:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking in git.git (Aug 2022, #06; Wed, 17)
X-master-at: 9bf691b78cf906751e65d65ba0c6ffdcd9a5a12c
X-next-at: 91fe8e635439f67be8837601cbf4bd61eddc41b4
Date:   Wed, 17 Aug 2022 19:23:25 -0700
Message-ID: <xmqq7d36s31e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDD6489C-1E9C-11ED-934C-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are the topics that have been cooking in my tree.  Commits
prefixed with '+' are in 'next' (being in 'next' is a sign that a
topic is stable enough to be used and are candidate to be in a future
release).  Commits prefixed with '-' are only in 'seen', and aren't
considered "accepted" at all.  A topic without enough support may be
discarded after a long period of no activity.

We are in the middle of the week #6 of a 12-week cycle (cf.
https://tinyurl.com/gitCal).

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

* vd/scalar-enables-fsmonitor (2022-08-16) 5 commits
 - scalar: update technical doc roadmap with FSMonitor support
 - scalar unregister: stop FSMonitor daemon
 - scalar: enable built-in FSMonitor on `register`
 - scalar-[un]register: clearly indicate source of error
 - scalar-unregister: handle error codes greater than 0

 "scalar" now enables built-in fsmonitor on enlisted repositories,
 when able.

 Will merge to 'next'?
 source: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>


* en/ancestry-path-in-a-range (2022-08-17) 2 commits
 - revision: allow --ancestry-path to take an argument
 - rev-list-options.txt: fix simple typo

 "git rev-list --ancestry-path=C A..B" is a natural extension of
 "git rev-list A..B"; instead of choosing a subset of A..B to those
 that have ancestry relationship with A, it lets a subset with
 ancestry relationship with C.

 Will merge to 'next'?
 source: <pull.1303.git.1660704498.gitgitgadget@gmail.com>


* en/submodule-merge-messages-fixes (2022-08-17) 3 commits
 - merge-ort: provide helpful submodule update message when possible
 - merge-ort: add comment to avoid surprise with new sub_flag variable
 - merge-ort: remove translator lego in new "submodule conflict suggestion"
 (this branch uses cw/submodule-merge-messages.)

 Further update the help messages given while merging submodules.

 Will merge to 'next'?
 source: <pull.1325.v2.git.1660718028.gitgitgadget@gmail.com>

--------------------------------------------------
[Cooking]

* ll/disk-usage-humanise (2022-08-11) 1 commit
  (merged to 'next' on 2022-08-14 at 3873a83f90)
 + rev-list: support human-readable output for `--disk-usage`

 "git rev-list --disk-usage" learned to take an optional value
 "human" to show the reported value in human-readable format, like
 "3.40MiB".

 Will merge to 'master'.
 source: <pull.1313.v5.git.1660193274336.gitgitgadget@gmail.com>


* ed/fsmonitor-on-network-disk (2022-08-11) 1 commit
  (merged to 'next' on 2022-08-14 at 637d458d9c)
 + fsmonitor: option to allow fsmonitor to run against network-mounted repos

 The built-in fsmonitor refuses to work on a network mounted
 repositories; a configuration knob for users to override this has
 been introduced.

 Will merge to 'master'.
 source: <pull.1317.v4.git.1660262231357.gitgitgadget@gmail.com>


* jk/is-promisor-object-keep-tree-in-use (2022-08-14) 1 commit
  (merged to 'next' on 2022-08-17 at 96033ff88d)
 + is_promisor_object(): fix use-after-free of tree buffer

 An earlier optimization discarded a tree-object buffer that is
 still in use, which has been corrected.

 Will merge to 'master'.
 source: <YviWO9Bhz5PU1HaL@coredump.intra.peff.net>


* js/fetch-negotiation-trace (2022-08-15) 1 commit
  (merged to 'next' on 2022-08-17 at 2c9e07b617)
 + fetch-pack: add tracing for negotiation rounds

 The common ancestor negotiation exchange during a "git fetch"
 session now leaves trace log.

 Will merge to 'master'.
 source: <4390677ec75d51487142adf7c2ab821cbd24a53e.1659477669.git.steadmon@google.com>


* pw/rebase-keep-base-fixes (2022-08-15) 5 commits
 - rebase --keep-base: imply --no-fork-point
 - rebase --keep-base: imply --reapply-cherry-picks
 - rebase: factor out merge_base calculation
 - rebase: store orig_head as a commit
 - t3416: set $EDITOR in subshell

 "git rebase --keep-base" used to discard the commits that are
 already cherry-picked to the upstream, even when "keep-base" meant
 that the base, on top of which the history is being rebuilt, does
 not yet include these cherry-picked commits.  The --keep-base
 option now implies --reapply-cherry-picks and --no-fork-point
 options.

 Needs review.
 source: <pull.1323.git.1660576283.gitgitgadget@gmail.com>


* fc/vimdiff-layout-vimdiff3-fix (2022-08-10) 7 commits
  (merged to 'next' on 2022-08-11 at a14fec292f)
 + mergetools: vimdiff: simplify tabfirst
 + mergetools: vimdiff: fix single window layouts
 + mergetools: vimdiff: rework tab logic
 + mergetools: vimdiff: fix for diffopt
 + mergetools: vimdiff: silence annoying messages
 + mergetools: vimdiff: make vimdiff3 actually work
 + mergetools: vimdiff: fix comment

 "vimdiff3" regression fix.

 Will merge to 'master'.
 source: <20220810154618.307275-1-felipe.contreras@gmail.com>


* jk/fsck-tree-mode-bits-fix (2022-08-10) 3 commits
  (merged to 'next' on 2022-08-11 at 219fe53025)
 + fsck: downgrade tree badFilemode to "info"
 + fsck: actually detect bad file modes in trees
 + tree-walk: add a mechanism for getting non-canonicalized modes

 "git fsck" reads mode from tree objects but canonicalizes the mode
 before passing it to the logic to check object sanity, which has
 hid broken tree objects from the checking logic.  This has been
 corrected, but to help exiting projects with broken tree objects
 that they cannot fix retroactively, the severity of anomalies this
 code detects has been demoted to "info" for now.

 Will merge to 'master'.
 source: <YvQcNpizy9uOZiAz@coredump.intra.peff.net>


* ag/merge-strategies-in-c (2022-08-10) 14 commits
 - sequencer: use the "octopus" strategy without forking
 - sequencer: use the "resolve" strategy without forking
 - merge: use the "octopus" strategy without forking
 - merge: use the "resolve" strategy without forking
 - merge-octopus: rewrite in C
 - merge-recursive: move better_branch_name() to merge.c
 - merge-resolve: rewrite in C
 - merge-one-file: rewrite in C
 - update-index: move add_cacheinfo() to read-cache.c
 - merge-index: add a new way to invoke `git-merge-one-file'
 - merge-index: drop the index
 - merge-index: libify merge_one_path() and merge_all()
 - t6060: add tests for removed files
 - t6060: modify multiple files to expose a possible issue with merge-index

 An attempt to rewrite remaining merge strategies from shell to C.
 source: <20220809185429.20098-1-alban.gruin@gmail.com>


* sy/mv-out-of-cone (2022-08-10) 9 commits
  (merged to 'next' on 2022-08-17 at 2316d9ce4d)
 + mv: check overwrite for in-to-out move
 + advice.h: add advise_on_moving_dirty_path()
 + mv: cleanup empty WORKING_DIRECTORY
 + mv: from in-cone to out-of-cone
 + mv: remove BOTH from enum update_mode
 + mv: check if <destination> is a SKIP_WORKTREE_DIR
 + mv: free the with_slash in check_dir_in_index()
 + mv: rename check_dir_in_index() to empty_dir_has_sparse_contents()
 + t7002: add tests for moving from in-cone to out-of-cone

 "git mv A B" in a sparsely populated working tree can be asked to
 move a path from a directory that is "in cone" to another directory
 that is "out of cone".  Handling of such a case has been improved.

 Will merge to 'master'.
 source: <20220809120910.2021413-1-shaoxuan.yuan02@gmail.com>


* sy/sparse-rm (2022-08-08) 5 commits
  (merged to 'next' on 2022-08-12 at 5bf10965fb)
 + rm: integrate with sparse-index
 + rm: expand the index only when necessary
 + pathspec.h: move pathspec_needs_expanded_index() from reset.c to here
 + t1092: add tests for `git-rm`
 + Merge branch 'vd/sparse-reset-checkout-fixes' into sy/sparse-rm
 (this branch uses vd/sparse-reset-checkout-fixes.)

 "git rm" has become more aware of the sparse-index feature.

 Will merge to 'master'.
 source: <20220807041335.1790658-1-shaoxuan.yuan02@gmail.com>


* vd/scalar-generalize-diagnose (2022-08-12) 11 commits
 - scalar: update technical doc roadmap
 - scalar-diagnose: use 'git diagnose --mode=all'
 - builtin/bugreport.c: create '--diagnose' option
 - builtin/diagnose.c: add '--mode' option
 - builtin/diagnose.c: create 'git diagnose' builtin
 - diagnose.c: add option to configure archive contents
 - scalar-diagnose: move functionality to common location
 - scalar-diagnose: move 'get_disk_info()' to 'compat/'
 - scalar-diagnose: add directory to archiver more gently
 - scalar-diagnose: avoid 32-bit overflow of size_t
 - scalar-diagnose: use "$GIT_UNZIP" in test

 The "diagnose" feature to create a zip archive for diagnostic
 material has been lifted from "scalar" and made into a feature of
 "git bugreport".

 Will merge to 'next'?
 source: <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>


* jk/pipe-command-nonblock (2022-08-17) 6 commits
  (merged to 'next' on 2022-08-17 at 91fe8e6354)
 + pipe_command(): mark stdin descriptor as non-blocking
 + pipe_command(): handle ENOSPC when writing to a pipe
 + pipe_command(): avoid xwrite() for writing to pipe
 + git-compat-util: make MAX_IO_SIZE define globally available
 + nonblock: support Windows
 + compat: add function to enable nonblocking pipes

 Fix deadlocks between main Git process and subprocess spawned via
 the pipe_command() API, that can kill "git add -p" that was
 reimplemented in C recently.

 Will merge to 'master'.
 source: <YvyE1RDFVAg4uQo1@coredump.intra.peff.net>


* es/mark-gc-cruft-as-experimental (2022-08-03) 2 commits
 - config: let feature.experimental imply gc.cruftPacks=true
 - gc: add tests for --cruft and friends

 Enable gc.cruftpacks by default for those who opt into
 feature.experimental setting.

 Expecting a reroll.
 cf. <220804.86a68ke9d5.gmgdl@evledraar.gmail.com>
 cf. <6803b725-526e-a1c8-f15c-a9ed4a144d4c@github.com>
 source: <20220803205721.3686361-1-emilyshaffer@google.com>


* vd/sparse-reset-checkout-fixes (2022-08-08) 4 commits
  (merged to 'next' on 2022-08-12 at 755d6ecdb8)
 + unpack-trees: unpack new trees as sparse directories
 + cache.h: create 'index_name_pos_sparse()'
 + oneway_diff: handle removed sparse directories
 + checkout: fix nested sparse directory diff in sparse index
 (this branch is used by sy/sparse-rm.)

 Fixes to sparse index compatibility work for "reset" and "checkout"
 commands.

 Will merge to 'master'.
 source: <pull.1312.v3.git.1659985672.gitgitgadget@gmail.com>


* sg/parse-options-subcommand (2022-07-25) 20 commits
 - builtin/worktree.c: let parse-options parse subcommands
 - builtin/stash.c: let parse-options parse subcommands
 - builtin/sparse-checkout.c: let parse-options parse subcommands
 - builtin/remote.c: let parse-options parse subcommands
 - builtin/reflog.c: let parse-options parse subcommands
 - builtin/notes.c: let parse-options parse subcommands
 - builtin/multi-pack-index.c: let parse-options parse subcommands
 - builtin/hook.c: let parse-option parse subcommands
 - builtin/gc.c: let parse-options parse 'git maintenance's subcommands
 - builtin/commit-graph.c: let parse-options parse subcommands
 - builtin/bundle.c: let parse-options parse subcommands
 - parse-options: add support for parsing subcommands
 - parse-options: drop leading space from '--git-completion-helper' output
 - parse-options: clarify the limitations of PARSE_OPT_NODASH
 - parse-options: PARSE_OPT_KEEP_UNKNOWN only applies to --options
 - api-parse-options.txt: fix description of OPT_CMDMODE
 - t0040-parse-options: test parse_options() with various 'parse_opt_flags'
 - t5505-remote.sh: check the behavior without a subcommand
 - t3301-notes.sh: check that default operation mode doesn't take arguments
 - git.c: update NO_PARSEOPT markings

 Introduce the "subcommand" mode to parse-options API and update the
 command line parser of Git commands with subcommands.

 Expecting a reroll.
 cf. <20220812152837.GC3790@szeder.dev>
 source: <20220725123857.2773963-1-szeder.dev@gmail.com>


* ds/bundle-uri-clone (2022-08-10) 5 commits
 - clone: --bundle-uri cannot be combined with --depth
 - bundle-uri: add support for http(s):// and file://
 - clone: add --bundle-uri option
 - bundle-uri: create basic file-copy logic
 - remote-curl: add 'get' capability

 Implement "git clone --bundle-uri".
 source: <pull.1300.v3.git.1660050703.gitgitgadget@gmail.com>


* ds/decorate-filter-tweak (2022-08-05) 11 commits
 - fetch: use ref_namespaces during prefetch
 - maintenance: stop writing log.excludeDecoration
 - log: create log.initialDecorationSet=all
 - log: add --clear-decorations option
 - log: add default decoration filter
 - log-tree: use ref_namespaces instead of if/else-if
 - refs: use ref_namespaces for replace refs base
 - refs: add array of ref namespaces
 - t4207: test coloring of grafted decorations
 - t4207: modernize test
 - refs: allow "HEAD" as decoration filter

 The namespaces used by "log --decorate" from "refs/" hierarchy by
 default has been tightened.

 Will merge to 'next'?
 source: <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>


* es/doc-creation-factor-fix (2022-07-28) 2 commits
 - range-diff: clarify --creation-factor=<factor>
 - format-patch: clarify --creation-factor=<factor>

 Expecting a reroll.
 source: <7229p500-p2r4-on87-6802-8o90s36rr3s4@tzk.qr>


* ab/submodule-helper-prep (2022-08-03) 28 commits
 - submodule--helper: fix bad config API usage
 - submodule--helper: libify "must_die_on_failure" code paths (for die)
 - submodule--helper: libify "must_die_on_failure" code paths
 - submodule--helper: libify determine_submodule_update_strategy()
 - submodule--helper: don't exit() on failure, return
 - submodule--helper: use "code" in run_update_command()
 - submodule--helper: move submodule_strategy_to_string() to only user
 - submodule--helper: don't call submodule_strategy_to_string() in BUG()
 - submodule--helper: add missing braces to "else" arm
 - submodule--helper: return "ret", not "1" from update_submodule()
 - submodule--helper: rename "int res" to "int ret"
 - submodule--helper: don't redundantly check "else if (res)"
 - submodule--helper: refactor "errmsg_str" to be a "struct strbuf"
 - submodule--helper: add "const" to copy of "update_data"
 - submodule--helper: pass a "const struct module_clone_data" to clone_submodule()
 - submodule--helper: move "sb" in clone_submodule() to its own scope
 - submodule--helper: use xstrfmt() in clone_submodule()
 - submodule--helper: replace memset() with { 0 }-initialization
 - submodule--helper style: add \n\n after variable declarations
 - submodule--helper style: don't separate declared variables with \n\n
 - submodule--helper: move "resolve-relative-url-test" to a test-tool
 - submodule--helper: move "check-name" to a test-tool
 - submodule--helper: move "is-active" to a test-tool
 - test-tool submodule-config: remove unused "--url" handling
 - submodule--helper: remove unused "list" helper
 - submodule--helper: remove unused "name" helper
 - submodule tests: test for "add <repository> <abs-path>"
 - submodule tests: test usage behavior
 (this branch is used by ab/submodule-helper-leakfix.)

 Code clean-up of "git submodule--helper".

 Expecting a (hopefully final?) reroll.
 cf. <220803.86h72tfpcc.gmgdl@evledraar.gmail.com>
 source: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>


* ab/dedup-config-and-command-docs (2022-07-29) 9 commits
 - docs: add CONFIGURATION sections that fuzzy map to built-ins
 - docs: add CONFIGURATION sections that map to a built-in
 - log docs: de-duplicate configuration sections
 - difftool docs: de-duplicate configuration sections
 - notes docs: de-duplicate configuration sections
 - apply docs: de-duplicate configuration sections
 - send-email docs: de-duplicate configuration sections
 - grep docs: de-duplicate configuration sections
 - docs: add and use include template for config/* includes

 Share the text used to explain configuration variables used by "git
 <subcmd>" in "git help <subcmd>" with the text from "git help config".

 Expecting a reroll.
 cf. <CAHd-oW5mD-H1kvuF9VEVb8KjaSkUSUpBH-WAkpCn6_Ci8o888w@mail.gmail.com>
 cf. <CAHd-oW7s6Hu24uTjCW9ROBbJkA5+7TCu32a4L_BXVLhcvw5kSw@mail.gmail.com>
 cf. <xmqqlesb4lwh.fsf@gitster.g>
 source: <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>


* cw/remote-object-info (2022-08-13) 7 commits
 - SQUASH???
 - cat-file: add remote-object-info to batch-command
 - transport: add client support for object-info
 - serve: advertise object-info feature
 - protocol-caps: initialization bug fix
 - fetch-pack: move fetch initialization
 - fetch-pack: refactor packet writing

 A client component to talk with the object-info endpoint.

 Expecting a reroll.
 cf. <20220728230210.2952731-1-calvinwan@google.com>
 cf. <CAFySSZDvgwbbHCHfyuaqX3tKsr-GjJ9iihygg6rNNe46Ys7_EA@mail.gmail.com>
 source: <20220728230210.2952731-1-calvinwan@google.com>


* mt/rot13-in-c (2022-08-14) 4 commits
 - tests: use the new C rot13-filter helper to avoid PERL prereq
 - t0021: implementation the rot13-filter.pl script in C
 - t0021: avoid grepping for a Perl-specific string at filter output
 - Merge branch 'mt/checkout-count-fix' into mt/rot13-in-c

 Test portability improvements.

 Will merge to 'next'?
 source: <cover.1660522524.git.matheus.bernardino@usp.br>


* tl/trace2-config-scope (2022-08-11) 2 commits
 - tr2: shows scope unconditionally in addition to key-value pair
 - api-trace2.txt: print config key-value pair

 Tweak trace2 output about configuration variables.
 source: <cover.1660272404.git.dyroneteng@gmail.com>


* ab/submodule-helper-leakfix (2022-08-03) 18 commits
 - submodule--helper: fix a configure_added_submodule() leak
 - submodule--helper: free rest of "displaypath" in "struct update_data"
 - submodule--helper: free some "displaypath" in "struct update_data"
 - submodule--helper: fix a memory leak in print_status()
 - submodule--helper: fix a leak in module_add()
 - submodule--helper: fix obscure leak in module_add()
 - submodule--helper: fix "reference" leak
 - submodule--helper: fix a memory leak in get_default_remote_submodule()
 - submodule--helper: fix a leak with repo_clear()
 - submodule--helper: fix "sm_path" and other "module_cb_list" leaks
 - submodule--helper: fix "errmsg_str" memory leak
 - submodule--helper: add and use *_release() functions
 - submodule--helper: don't leak {run,capture}_command() cp.dir argument
 - submodule--helper: "struct pathspec" memory leak in module_update()
 - submodule--helper: fix most "struct pathspec" memory leaks
 - submodule--helper: fix trivial get_default_remote_submodule() leak
 - submodule--helper: fix a leak in "clone_submodule"
 - Merge branch 'ab/submodule-helper-prep' into ab/submodule-helper-leakfix
 (this branch uses ab/submodule-helper-prep.)

 Plugging leaks in submodule--helper.

 Waiting for the "prep" step.
 source: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com>


* cw/submodule-merge-messages (2022-08-04) 1 commit
  (merged to 'next' on 2022-08-12 at ede0890319)
 + submodule merge: update conflict error message
 (this branch is used by en/submodule-merge-messages-fixes.)

 Update the message given when "git merge" sees conflicts at a path
 with a submodule while merging a superproject.

 Will wait for en/submodule-merge-messages-fixes to mature.
 source: <20220804195105.1303455-1-calvinwan@google.com>


* po/doc-add-renormalize (2022-08-10) 1 commit
  (merged to 'next' on 2022-08-11 at 53851663eb)
 + doc add: renormalize is not idempotent for CRCRLF

 Documentation for "git add --renormalize" has been improved.

 Will merge to 'master'.
 source: <20220810144450.470-2-philipoakley@iee.email>


* po/glossary-around-traversal (2022-07-09) 3 commits
 - glossary: add reachability bitmap description
 - glossary: add commit graph description
 - glossary: add Object DataBase (ODB) abbreviation

 The glossary entries for "commit-graph file" and "reachability
 bitmap" have been added.

 Expecting a reroll.
 cf. <dfe0c1ab-33f8-f13e-71ce-1829bb0d2d7f@iee.email>
 source: <pull.1282.git.1657385781.gitgitgadget@gmail.com>


* ac/bitmap-lookup-table (2022-08-14) 6 commits
 - bitmap-lookup-table: add performance tests for lookup table
 - pack-bitmap: prepare to read lookup table extension
 - pack-bitmap-write: learn pack.writeBitmapLookupTable and add tests
 - pack-bitmap-write.c: write lookup table extension
 - bitmap: move `get commit positions` code to `bitmap_writer_finish`
 - Documentation/technical: describe bitmap lookup table extension

 The pack bitmap file gained a bitmap-lookup table to speed up
 locating the necessary bitmap for a given commit.
 source: <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>


* tb/show-ref-count (2022-06-06) 2 commits
 - builtin/show-ref.c: limit output with `--count`
 - builtin/show-ref.c: rename `found_match` to `matches_nr`

 "git show-ref" learned to stop after emitting N refs with the new
 "--count=N" option.

 Expecting a reroll.
 cf. <xmqqczfl4ce1.fsf@gitster.g>
 source: <cover.1654552560.git.me@ttaylorr.com>


* ds/bundle-uri-more (2022-08-10) 2 commits
  (merged to 'next' on 2022-08-12 at 4f445a058d)
 + bundle-uri: add example bundle organization
 + docs: document bundle URI standard

 The "bundle URI" design gets documented.

 Will merge to 'master'.
 source: <pull.1248.v4.git.1660050761.gitgitgadget@gmail.com>


* js/bisect-in-c (2022-06-27) 16 commits
 - bisect: no longer try to clean up left-over `.git/head-name` files
 - bisect: remove Cogito-related code
 - Turn `git bisect` into a full built-in
 - bisect: move even the command-line parsing to `bisect--helper`
 - bisect: teach the `bisect--helper` command to show the correct usage strings
 - bisect--helper: return only correct exit codes in `cmd_*()`
 - bisect--helper: move the `BISECT_STATE` case to the end
 - bisect--helper: make `--bisect-state` optional
 - bisect--helper: align the sub-command order with git-bisect.sh
 - bisect--helper: using `--bisect-state` without an argument is a bug
 - bisect--helper: really retire `--bisect-autostart`
 - bisect--helper: really retire --bisect-next-check
 - bisect--helper: retire the --no-log option
 - bisect: avoid double-quoting when printing the failed command
 - bisect run: fix the error message
 - bisect: verify that a bogus option won't try to start a bisection

 Final bits of "git bisect.sh" have been rewritten in C.

 Expecting a (hopefully final) reroll.
 cf. <20627.86ilolhnnn.gmgdl@evledraar.gmail.com>
 source: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>

--------------------------------------------------
[Discarded]

* mb/doc-rerere-autoupdate (2022-07-15) 1 commit
 . cherry-pick doc: clarify no-rerere-autoupdate still allows rerere

 Clarifies that the "--no-rerere-autoupdate" option does not disable
 the "rerere" mechanism (nor does "--rerere-autoupdate" enable it).

 Superseded by jc/rerere-autoupdate-doc
 source: <20220715092527.1567837-1-mail@beyermatthias.de>


* fr/vimdiff-layout-colors-fix (2022-08-07) 3 commits
 . mergetools: vimdiff: update unit tests
 . mergetools: vimdiff: fix single tab mode, single window mode and colors
 . mergetools: vimdiff: fix comment

 "vimdiff3" regression fix.

 Superseded by fc/vimdiff-layout-vimdiff3-fix
 source: <20220808053459.184367-1-greenfoo@u92.eu>


* tk/apply-case-insensitive (2022-06-21) 3 commits
 . apply: support case-only renames in case-insensitive filesystems
 . reset: new failing test for reset of case-insensitive duplicate in index
 . t4141: test "git apply" with core.ignorecase

 "git apply" barfed on a patch that makes a case-only rename on a
 case-insensitive filesystem.

 In stalled state for too long.
 source: <pull.1257.v2.git.1655655027.gitgitgadget@gmail.com>


* bc/stash-export (2022-04-08) 4 commits
 . builtin/stash: provide a way to import stashes from a ref
 . builtin/stash: provide a way to export stashes to a ref
 . builtin/stash: factor out revision parsing into a function
 . object-name: make get_oid quietly return an error

 A mechanism to export and import stash entries to and from a normal
 commit to transfer it across repositories has been introduced.

 In stalled state for too long.
 cf. <YnL2d4Vr9Vr7W4Hj@camp.crustytoothpaste.net>
 source: <20220407215352.3491567-1-sandals@crustytoothpaste.net>


* jt/connected-show-missing-from-which-side (2022-06-10) 1 commit
 . fetch,fetch-pack: clarify connectivity check error

 We may find an object missing after a "git fetch" stores the
 objects it obtained from the other side, but it is not necessarily
 because the remote failed to send necessary objects.  Reword the
 messages in an attempt to help users explore other possibilities
 when they hit this error.

 In stalled state for too long.
 Also it seems to break t5326 with sha256.
 source: <20220610195247.1177549-1-jonathantanmy@google.com>
