FROM docker:latest

# Custom instructions for the Docker image
# ...

COPY docker/replica_transfer/copy_files.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/copy_files.sh
CMD ["/usr/local/bin/copy_files.sh"]

ENTRYPOINT ["/bin/sh", "-c"]

