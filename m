Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB9DC433EF
	for <git@archiver.kernel.org>; Thu, 26 May 2022 14:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243461AbiEZOwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 10:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347839AbiEZOup (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 10:50:45 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0C980207
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:43 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p8so1869899pfh.8
        for <git@vger.kernel.org>; Thu, 26 May 2022 07:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OKk6N+aYgoXUBigap2OuunZ3HhgB0/XtEPI/ek/80jM=;
        b=SPTGidxJrkzT7JPSjnQ756ztfgrIfxDEqwg4ZEzdUKK/R0wzzLaclB2hy9McDSIsGK
         PgVb9PQVUsBqG98046Gcfaqw+PnEXkvDdgSPsKF0InvyN40s/SbmmvKzzyi+dMWZKsxM
         Pq4T1O11IPYajpBkMThO5dnUMqs/uPtWnS2RV8mmP/+RgbJgUZvJ500lmjOZCB2rRFt7
         EHyrH8xOx95ivoNhiiODCJjsbGw2eNEfPtUhpdSbSiV95Xlh0GG5QSsagGWDUEnZdCEI
         Jc6TM8WDHnQkI32N+6XPllest1lGhWkWUgBccVaz2imO/yV1Qlf59J6fuw41IV1Jj4z4
         hwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OKk6N+aYgoXUBigap2OuunZ3HhgB0/XtEPI/ek/80jM=;
        b=n/jvVqsXwUIU/iRg1T4Rc6oxLLu5DteR2L5SoXkBU81O0EZqsOc0LnKhI4PLTYFIxV
         aMWs9mrEdn/LooX5RR1mAw4alTlhHSvMnOuPB3Wv+BPHeogzPcplzLWN3Q3sWNgBkxW7
         hVIkrcgDSUWS1f5NMF5kfJHOvpacYfFSJv8GeBszj+yQ7tR+bXHrW6eJ/icMFt0TUU/q
         gb8qW4/oA9cCGPGrs+6roG5C93UB7I0gdoXMR/KH0IHQrCTsEoB+H/xqR9SE4PKBts8J
         AvvvctWdENH1HsPU9tmbGUmtZgvIM1HyIUALXbzBb6XfJ8AUnsbO4SHIJBQ+8KcZEYae
         YS6w==
X-Gm-Message-State: AOAM530arNGBuYDCKbWhH9AVZ6375v9a/egJID5PJG05Ljz2CRGR6leS
        qsp9MJUkkZUDPLUJUrCMlWw=
X-Google-Smtp-Source: ABdhPJwwrg5pXdtuVUhccQgIxTTwri1fjkd79dL67cfd0M43KZH0EFEzLLrLaj1HyKVr1FD1Iy4cKQ==
X-Received: by 2002:a63:5304:0:b0:3fb:92eb:8e90 with SMTP id h4-20020a635304000000b003fb92eb8e90mr1057379pgb.36.1653576642643;
        Thu, 26 May 2022 07:50:42 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id i16-20020a056a00005000b00518382bceaesm1597480pfk.57.2022.05.26.07.50.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 May 2022 07:50:42 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Cc:     Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v5 03/10] Makefile: have "make pot" not "reset --hard"
Date:   Thu, 26 May 2022 22:50:28 +0800
Message-Id: <20220526145035.18958-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20220523152128.26380-1-worldhello.net@gmail.com>
References: <20220523152128.26380-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Before commit fc0fd5b23b (Makefile: help gettext tools to cope with our
custom PRItime format, 2017-07-20), we'd consider source files as-is
with gettext, but because we need to understand PRItime in the same way
that gettext itself understands PRIuMAX, we'd first check if we had a
clean checkout, then munge all of the processed files in-place with
"sed", generate "po/git.pot", and then finally "reset --hard" to undo
our changes.

By generating "pot" snippets in ".build/pot/po" for each source file
and rewriting certain source files with PRItime macros to temporary
files in ".build/pot/po", we can avoid running "make pot" by altering
files in place and doing a "reset --hard" afterwards.

This speed of "make pot" is slower than before on an initial run,
because we run "xgettext" many times (once per source file), but it
can be boosted by parallelization. It is *much* faster for incremental
runs, and will allow us to implement related targets in subsequent
commits.

When the "pot" target was originally added in cd5513a7168 (i18n:
Makefile: "pot" target to extract messages marked for translation,
2011-02-22) it behaved like a "normal" target. I.e. we'd skip the
re-generation of the po/git.pot if nothing had to be done.

Then after po/git.pot was checked in in dce37b66fb0 (l10n: initial
git.pot for 1.7.10 upcoming release, 2012-02-13) the target was broken
until 1f31963e921 (i18n: treat "make pot" as an explicitly-invoked
target, 2014-08-22) when it was made to depend on "FORCE". I.e. the
Makefile's dependency resolution inherently can't handle incremental
building when the target file may be updated by git (or something else
external to "make"). But this case no longer applies, so FORCE is no
longer needed.

That out of the way, the main logic change here is getting rid of the
"reset --hard":

We'll generate intermediate ".build/pot/po/%.po" files from "%", which
is handy to see at a glance what strings (if any) in a given file are
marked for translation:

	$ make .build/pot/po/pretty.c.po
	[...]
	$ cat .build/pot/po/pretty.c.po
	#: pretty.c:1051
	msgid "unable to parse --pretty format"
	msgstr ""
	$

For these C source files which contain the PRItime macros, we will
create temporary munged "*.c" files in a tree in ".build/pot/po"
corresponding to our source tree, and have "xgettext" consider those.
The rule needs to be careful to "(cd .build/pot/po && ...)", because
otherwise the comments in the po/git.pot file wouldn't refer to the
correct source locations (they'd be prefixed with ".build/pot/po").
These temporary munged "*.c” files will be removed immediately after
the corresponding po files are generated, because some development tools
cannot ignore the duplicate source files in the ".build" directory
according to the ".gitignore" file, and that may cause trouble.

The output of the generated po/git.pot file is changed in one minor
way: Because we're using msgcat(1) instead of xgettext(1) to
concatenate the output we'll now disambiguate where "TRANSLATORS"
comments come from, in cases where a message is the same in N files,
and either only one has a "TRANSLATORS" comment, or they're
different. E.g. for the "Your edited hunk[...]" message we'll now
apply this change (comment content elided):

	+#. #-#-#-#-#  add-patch.c.po  #-#-#-#-#
	 #. TRANSLATORS: do not translate [y/n]
	[...]
	+#. #-#-#-#-#  git-add--interactive.perl.po  #-#-#-#-#
	 #. TRANSLATORS: do not translate [y/n]
	[...]
	 #: add-patch.c:1253 git-add--interactive.perl:1244
	 msgid ""
	 "Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
	 msgstr ""

There are six such changes, and they all make the context more
understandable, as msgcat(1) is better at handling these edge cases
than xgettext(1)'s previously used "--join-existing" flag.

But filenames in the above disambiguation lines of extracted-comments
have an extra ".po" extension compared to the filenames at the file
locations. While we could rename the intermediate ".build/pot/po/%.po"
files without the ".po" extension to use more intuitive filenames in
the disambiguation lines of extracted-comments, but that will confuse
developer tools with lots of invalid C or other source files in
".build/pot/po" directory.

The addition of "--omit-header" option for xgettext makes the "pot"
snippets in ".build/pot/po/*.po" smaller. But as we'll see in a
subsequent commit this header behavior has been hiding an
encoding-related bug from us, so let's carry it forward instead of
re-generating it with xgettext(1).

The "po/git.pot" file should have a header entry, because a proper
header entry will increase the speed of creating a new po file using
msginit and set a proper "POT-Creation-Date:" field in the header
entry of a "po/XX.po" file. We use xgettext to generate a separate
header file at ".build/pot/git.header" from "/dev/null", and use this
header to assemble "po/git.pot".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 .gitignore |  1 +
 Makefile   | 80 ++++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 60 insertions(+), 21 deletions(-)

diff --git a/.gitignore b/.gitignore
index e81de1063a..a452215764 100644
--- a/.gitignore
+++ b/.gitignore
@@ -200,6 +200,7 @@
 *.[aos]
 *.o.json
 *.py[co]
+.build/
 .depend/
 *.gcda
 *.gcno
diff --git a/Makefile b/Makefile
index f2f9c9bc81..49176822ad 100644
--- a/Makefile
+++ b/Makefile
@@ -569,6 +569,7 @@ INSTALL = install
 TCL_PATH = tclsh
 TCLTK_PATH = wish
 XGETTEXT = xgettext
+MSGCAT = msgcat
 MSGFMT = msgfmt
 CURL_CONFIG = curl-config
 GCOV = gcov
@@ -855,6 +856,7 @@ SOURCES_CMD = ( \
 		-o \( -name '[tp][0-9][0-9][0-9][0-9]*' -prune \) \
 		-o \( -name contrib -type d -prune \) \
 		-o \( -name build -type d -prune \) \
+		-o \( -name .build -type d -prune \) \
 		-o \( -name 'trash*' -type d -prune \) \
 		-o \( -name '*.[hcS]' -type f -print \) \
 		-o \( -name '*.sh' -type f -print \) \
@@ -2706,6 +2708,7 @@ XGETTEXT_FLAGS = \
 	--force-po \
 	--add-comments=TRANSLATORS: \
 	--msgid-bugs-address="Git Mailing List <git@vger.kernel.org>" \
+	--package-name=Git \
 	--from-code=UTF-8
 XGETTEXT_FLAGS_C = $(XGETTEXT_FLAGS) --language=C \
 	--keyword=_ --keyword=N_ --keyword="Q_:1,2"
@@ -2724,34 +2727,68 @@ LOCALIZED_SH += t/t0200/test.sh
 LOCALIZED_PERL += t/t0200/test.perl
 endif
 
-## Note that this is meant to be run only by the localization coordinator
-## under a very controlled condition, i.e. (1) it is to be run in a
-## Git repository (not a tarball extract), (2) any local modifications
-## will be lost.
+## We generate intermediate .build/pot/po/%.po files containing a
+## extract of the translations we find in each file in the source
+## tree. We will assemble them using msgcat to create the final
+## "po/git.pot" file.
+LOCALIZED_ALL_GEN_PO =
+
+LOCALIZED_C_GEN_PO = $(LOCALIZED_C:%=.build/pot/po/%.po)
+LOCALIZED_ALL_GEN_PO += $(LOCALIZED_C_GEN_PO)
+
+LOCALIZED_SH_GEN_PO = $(LOCALIZED_SH:%=.build/pot/po/%.po)
+LOCALIZED_ALL_GEN_PO += $(LOCALIZED_SH_GEN_PO)
+
+LOCALIZED_PERL_GEN_PO = $(LOCALIZED_PERL:%=.build/pot/po/%.po)
+LOCALIZED_ALL_GEN_PO += $(LOCALIZED_PERL_GEN_PO)
+
 ## Gettext tools cannot work with our own custom PRItime type, so
 ## we replace PRItime with PRIuMAX.  We need to update this to
 ## PRIdMAX if we switch to a signed type later.
+$(LOCALIZED_C_GEN_PO): .build/pot/po/%.po: %
+	$(call mkdir_p_parent_template)
+	$(QUIET_XGETTEXT) \
+	    if grep -q PRItime $<; then \
+		(\
+			sed -e 's|PRItime|PRIuMAX|g' <$< \
+				>.build/pot/po/$< && \
+			cd .build/pot/po && \
+			$(XGETTEXT) --omit-header \
+				-o $(@:.build/pot/po/%=%) \
+				$(XGETTEXT_FLAGS_C) $< && \
+			rm $<; \
+		); \
+	    else \
+		$(XGETTEXT) --omit-header \
+			-o $@ $(XGETTEXT_FLAGS_C) $<; \
+	    fi
 
-po/git.pot: $(GENERATED_H) FORCE
-	# All modifications will be reverted at the end, so we do not
-	# want to have any local change.
-	git diff --quiet HEAD && git diff --quiet --cached
+$(LOCALIZED_SH_GEN_PO): .build/pot/po/%.po: %
+	$(call mkdir_p_parent_template)
+	$(QUIET_XGETTEXT)$(XGETTEXT) --omit-header \
+		-o$@ $(XGETTEXT_FLAGS_SH) $<
 
-	@for s in $(LOCALIZED_C) $(LOCALIZED_SH) $(LOCALIZED_PERL); \
-	do \
-		sed -e 's|PRItime|PRIuMAX|g' <"$$s" >"$$s+" && \
-		cat "$$s+" >"$$s" && rm "$$s+"; \
-	done
+$(LOCALIZED_PERL_GEN_PO): .build/pot/po/%.po: %
+	$(call mkdir_p_parent_template)
+	$(QUIET_XGETTEXT)$(XGETTEXT) --omit-header \
+		-o$@ $(XGETTEXT_FLAGS_PERL) $<
+
+define gen_pot_header
+$(XGETTEXT) $(XGETTEXT_FLAGS_C) \
+	-o - /dev/null | \
+sed -e 's|charset=CHARSET|charset=UTF-8|' \
+    -e 's|\(Last-Translator: \)FULL NAME <.*>|\1make by the Makefile|' \
+    -e 's|\(Language-Team: \)LANGUAGE <.*>|\1Git Mailing List <git@vger.kernel.org>|' \
+    >$@ && \
+echo '"Plural-Forms: nplurals=INTEGER; plural=EXPRESSION;\\n"' >>$@
+endef
 
-	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ $(XGETTEXT_FLAGS_C) $(LOCALIZED_C)
-	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_SH) \
-		$(LOCALIZED_SH)
-	$(QUIET_XGETTEXT)$(XGETTEXT) -o$@+ --join-existing $(XGETTEXT_FLAGS_PERL) \
-		$(LOCALIZED_PERL)
+.build/pot/git.header: $(LOCALIZED_ALL_GEN_PO)
+	$(call mkdir_p_parent_template)
+	$(QUIET_GEN)$(gen_pot_header)
 
-	# Reverting the munged source, leaving only the updated $@
-	git reset --hard
-	mv $@+ $@
+po/git.pot: .build/pot/git.header $(LOCALIZED_ALL_GEN_PO) FORCE
+	$(QUIET_GEN)$(MSGCAT) $(filter-out FORCE,$^) >$@
 
 .PHONY: pot
 pot: po/git.pot
@@ -3290,6 +3327,7 @@ cocciclean:
 	$(RM) contrib/coccinelle/*.cocci.patch*
 
 clean: profile-clean coverage-clean cocciclean
+	$(RM) -r .build
 	$(RM) *.res
 	$(RM) $(OBJECTS)
 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
-- 
2.36.0.1.g15c4090757

