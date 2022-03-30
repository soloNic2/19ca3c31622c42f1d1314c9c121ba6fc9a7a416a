Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B315DC433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 22:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351692AbiC3Ws0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 18:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348450AbiC3WsZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 18:48:25 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007272BB18
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:46:38 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id t21so18704646oie.11
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 15:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QIyFaXq1yu/Fpbk+nYXefPfn2oaAWQlQvDu3X4W8O+E=;
        b=Bm1esmrCPeuPolEt5rog49bX44YO486IuxJ8cf+R1aNRPWO35OLM+i/XDBx9D5Qa4J
         /YCxcF2C8Xa/gEOrBVZTw5VThAJgZ5Bc6PfTB6cpj7bKhhwquvF0PDM1YKgRc3NVCabb
         icXAHL2/Gt5ys8oeGq8rS0SfsjIm1iyeivpI21dw9PQdwIIOwTTzJ6rMWI4sigxpNauF
         qns/7cFZ0X4hYL4hdyNTuca2k+ND+T6RAZ5d4cBnJCSDsWXIR0fr67JCULgwJ3w2hXXt
         8HzRSAKnZ5Paxiv+AwpfWdkpTqK02vOGk96V8uqzdJ6mYm3NCUyS3evwAvbMD1aljmUS
         gvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=QIyFaXq1yu/Fpbk+nYXefPfn2oaAWQlQvDu3X4W8O+E=;
        b=vgTmzavr9vPiSc2SfVcZ2B8T/lBMt3FQ4XqSt1heyjHGAq0RktvEe1HMO/7wheB9/Z
         vNXOn+23AMx65evvpbuyfWhborKZ9Ik7bnf5PLKW6nbYMfnneIBhCSnjuDlhJEERDfV1
         mMeze2pLv5Mjcq2lCjC+zk33u04Ai6XRD75iBZdp9WStCQJthTM9R8OFh4M41Quegad1
         wH8oYt5IU+KC5V/aLTbFSN8zxSkJ3j31EFAg1ITlwtVvBV50NSzHFjvkA8mvSuBp6Uv0
         GADOrvW+5Z6SRvxmA7aIagkqajfPMWHbRE15Z6UQSp830CEn/TFt3glnt8yiFuqQfcqK
         Aa6A==
X-Gm-Message-State: AOAM5336Kr/adIIKjHwxoCvfltZmCjZdWfyvdZ2t1vB99EzrIDyeWCH7
        M1B3o476PmMSRz/WP9RFBmq/kVmgc9eU2DhrhVOsHQ==
X-Google-Smtp-Source: ABdhPJxBH2Au3XE0t7pINv4Ryj1NcHQq2zMMkIByiWpceuaBlBi0wSc0G33Kc1p+P2UaFce4WFuNHOYHGLJaMyIgJco=
X-Received: by 2002:a05:6808:1386:b0:2d9:a01a:488a with SMTP id
 c6-20020a056808138600b002d9a01a488amr1299060oiw.213.1648680398148; Wed, 30
 Mar 2022 15:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220208235631.732466-1-calvinwan@google.com> <20220328191112.3092139-1-calvinwan@google.com>
 <20220328191112.3092139-4-calvinwan@google.com> <YkTV19+eCQNq/C5s@google.com>
In-Reply-To: <YkTV19+eCQNq/C5s@google.com>
From:   Calvin Wan <calvinwan@google.com>
Date:   Wed, 30 Mar 2022 15:46:27 -0700
Message-ID: <CAFySSZDWYN6sKZgm=XKcZUb0OgYBKPwn9OX92m4Ybgr+XZ_8LQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] object-info: add option for retrieving object info
To:     Josh Steadmon <steadmon@google.com>,
        Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        jonathantanmy@google.com, philipoakley@iee.email,
        johncai86@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> but the oid arguments below have a newline, so we
> should be consistent one way or the other.

To match what the other packet functions do, I will get rid of the new
line for the oid loop.

> Rather than die() if we're on protocol V1
> or V0, can we also return a failure here and let callers fallback to
> fetch?

Sounds reasonable. Will look into it.

On Wed, Mar 30, 2022 at 3:12 PM Josh Steadmon <steadmon@google.com> wrote:
>
> On 2022.03.28 19:11, Calvin Wan wrote:
> > Sometimes it is useful to get information about an object without
> > having to download it completely. The server logic has already been
> > implemented as =E2=80=9Ca2ba162cda (object-info: support for retrieving=
 object
> > info, 2021-04-20)=E2=80=9D. This patch implements the client option for
> > it. Currently, only 'size' is supported, however future patches can
> > implement additional options.
> >
> > Add =E2=80=98--object-info=E2=80=99 option to fetch. This option allows=
 the client to
> > make an object-info command request to a server that supports protocol
> > v2. If the server is v2, but does not allow for the object-info
> > command request, fetch the objects as if it were a standard fetch
> > (however without changing any refs). Therefore, hook `fetch
> > object-info` into transport_fetch_refs() to easily fallback if needed.
> >
> > A previous patch added the `transfer.advertiseObjectInfo` config
> > option, of which this patch utilizes to test the fallback.
> >
> > ---
> >  Documentation/fetch-options.txt |   5 ++
> >  Documentation/git-fetch.txt     |   1 +
> >  builtin/fetch.c                 |  36 ++++++++-
> >  fetch-pack.c                    |  42 +++++++++-
> >  fetch-pack.h                    |   9 +++
> >  t/t5583-fetch-object-info.sh    | 138 ++++++++++++++++++++++++++++++++
> >  transport-helper.c              |   8 +-
> >  transport-internal.h            |   1 +
> >  transport.c                     |  75 ++++++++++++++++-
> >  transport.h                     |   9 +++
> >  10 files changed, 315 insertions(+), 9 deletions(-)
> >  create mode 100755 t/t5583-fetch-object-info.sh
>
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index b709a61baf..36e3d1c5d0 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -1269,6 +1269,27 @@ static void write_command_and_capabilities(struc=
t strbuf *req_buf,
> >       packet_buf_delim(req_buf);
> >  }
> >
> > +void send_object_info_request(int fd_out, struct object_info_args *arg=
s)
> > +{
> > +     struct strbuf req_buf =3D STRBUF_INIT;
> > +     int i;
> > +
> > +     write_command_and_capabilities(&req_buf, args->server_options, "o=
bject-info");
> > +
> > +     if (string_list_has_string(args->object_info_options, "size"))
> > +             packet_buf_write(&req_buf, "size");
>
> Do we need a newline after "size" here? It's not clear to me that it's
> necessary; Documentation/technical/protocol-v2.txt just says
> "command-specific-args are packet line framed arguments defined by each
> individual command", but the oid arguments below have a newline, so we
> should be consistent one way or the other.
>
> It looks like the server-side implementation wants just a bare "size"
> string (no newline), but I suspect that either is OK because the
> packet_reader is probably using PACKET_READ_CHOMP_NEWLINE.
>
>
> > +     for (i =3D 0; i < args->oids->nr; i++) {
> > +             packet_buf_write(&req_buf, "oid %s\n", oid_to_hex(&args->=
oids->oid[i]));
> > +     }
> > +
> > +     packet_buf_flush(&req_buf);
> > +     if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
> > +             die_errno(_("unable to write request to remote"));
> > +
> > +     strbuf_release(&req_buf);
> > +}
> > +
>
> > diff --git a/transport.c b/transport.c
> > index 70e9840a90..65a1b1fdb3 100644
> > --- a/transport.c
> > +++ b/transport.c
> > @@ -350,6 +350,67 @@ static struct ref *handshake(struct transport *tra=
nsport, int for_push,
> >       return refs;
> >  }
> >
> > +/*
> > + * Fetches object info if server supports object-info command
> > + * Make sure to fallback to normal fetch if this fails
> > + */
> > +static int fetch_object_info(struct transport *transport)
> > +{
> > +     struct git_transport_data *data =3D transport->data;
> > +     struct object_info_args args;
> > +     struct packet_reader reader;
> > +
> > +     memset(&args, 0, sizeof(args));
> > +     args.server_options =3D transport->server_options;
> > +     args.object_info_options =3D transport->smart_options->object_inf=
o_options;
> > +     args.oids =3D transport->smart_options->object_info_oids;
> > +
> > +     connect_setup(transport, 0);
> > +     packet_reader_init(&reader, data->fd[0], NULL, 0,
> > +                     PACKET_READ_CHOMP_NEWLINE |
> > +                     PACKET_READ_DIE_ON_ERR_PACKET);
> > +     data->version =3D discover_version(&reader);
> > +
> > +     transport->hash_algo =3D reader.hash_algo;
> > +
> > +     switch (data->version) {
> > +     case protocol_v2:
> > +             if (!server_supports_v2("object-info", 0))
> > +                     return 0;
> > +             send_object_info_request(data->fd[1], &args);
> > +             break;
> > +     case protocol_v1:
> > +     case protocol_v0:
> > +             die(_("wrong protocol version. expected v2"));
>
> The comment at the top of this function says that callers should be
> prepared to fallback to normal fetch if this function fails. The only
> way it can currently fail is if we are using protocol V2 but the server
> doesn't support object-info. Rather than die() if we're on protocol V1
> or V0, can we also return a failure here and let callers fallback to
> fetch?
>
> > +     case protocol_unknown_version:
> > +             BUG("unknown protocol version");
> > +     }
> > +
> > +     if (packet_reader_read(&reader) !=3D PACKET_READ_NORMAL) {
> > +             die(_("error reading object info header"));
> > +     }
> > +     if (strcmp(reader.line, "size")) {
> > +             die(_("expected 'size', received '%s'"), reader.line);
> > +     }
> > +     while (packet_reader_read(&reader) =3D=3D PACKET_READ_NORMAL) {
> > +             printf("%s\n", reader.line);
> > +     }
> > +     check_stateless_delimiter(transport->stateless_rpc, &reader, "sta=
teless delimiter expected");
> > +
> > +     return 1;
> > +}
> > +
