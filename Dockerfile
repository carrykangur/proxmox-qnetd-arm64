FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        corosync-qnetd \
        corosync-qdevice \
        openssh-server && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd /root/.ssh && chmod 700 /root/.ssh

COPY run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 5403
EXPOSE 22

CMD ["/run.sh"]
