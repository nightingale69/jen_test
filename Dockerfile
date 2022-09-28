FROM node:16-alpine

# Set up JS-DOS, NPM packages
WORKDIR site
RUN wget https://js-dos.com/6.22/current/js-dos.js && \
    wget https://js-dos.com/6.22/current/wdosbox.js && \
    wget https://js-dos.com/6.22/current/wdosbox.wasm.js
RUN npm install -g serve

# Get Game
ARG GAME_URL=https://archive.org/download/Doom-2/Doom2.zip
RUN wget -O game.zip $GAME_URL

# Set up game hosting
ARG GAME_ARGS=\"DOOM2.EXE\"
COPY index.html .
RUN sed -i s/GAME_ARGS/$GAME_ARGS/ index.html

ENTRYPOINT npx serve -l tcp://0.0.0.0:8000
