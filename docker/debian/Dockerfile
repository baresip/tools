FROM bitnami/minideb:buster
RUN install_packages build-essential libopus-dev pkg-config git ca-certificates
WORKDIR /root/
RUN git clone https://github.com/baresip/re.git
RUN git clone https://github.com/baresip/rem.git
RUN git clone https://github.com/baresip/baresip.git
RUN cd re && make -j$(nproc) libre.a
RUN cd rem && make -j$(nproc) librem.a
RUN cd baresip && make -j$(nproc) STATIC=1

FROM bitnami/minideb:buster
RUN install_packages libopus0
WORKDIR /root/
COPY --from=0 /root/baresip/baresip .
CMD ["./baresip"]  
