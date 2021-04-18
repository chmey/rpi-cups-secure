FROM  alpine:latest

RUN apk update --no-cache
RUN apk add --no-cache cups cups-libs cups-client cups-filters avahi
RUN apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing gutenprint cups-pdf hplip gutenprint-cups


# Create user `print`
RUN adduser --disabled-password print && \
    addgroup print lp && addgroup print lpadmin

RUN sed -i "s/^AccessLog *= *.*/AccessLog = stderr/; s/^AccessLog [^=]*$/AccessLog stderr/" /etc/cups/cups-files.conf &&\
    sed -i "s/^ErrorLog *= *.*/ErrorLog = stderr/; s/^ErrorLog [^=]*$/ErrorLog stderr/" /etc/cups/cups-files.conf && \
    sed -i "s/^PageLog *= *.*/PageLog = stderr/; s/^PageLog [^=]*$/PageLog stderr/" /etc/cups/cups-files.conf


COPY cupsd.conf /etc/cups/cupsd.conf
COPY entry.sh /opt/entry.sh

# Expose cups
EXPOSE 631
# Expose avahi advertisement
EXPOSE 5353/udp

ENTRYPOINT [ "/bin/sh", "/opt/entry.sh"]
