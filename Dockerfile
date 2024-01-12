# Use a specific version of node that is compatible with your engines requirement
FROM node:12-alpine 

# Create app directory and set proper permissions
RUN mkdir -p /usr/src/node-app && chown -R node:node /usr/src/node-app

WORKDIR /usr/src/node-app

# Copy package.json and yarn.lock or package-lock.json
COPY package*.json yarn.lock* ./

# Environment Variables
# ENV PORT=3000 \
#     MONGODB_URL=mongodb+srv://taskcraft:taskcraft@cluster0.nqxtj.mongodb.net/node-production-app?retryWrites=true&w=majority \
#     JWT_SECRET=thisisasamplesecret \
#     JWT_ACCESS_EXPIRATION_MINUTES=30 \
#     JWT_REFRESH_EXPIRATION_DAYS=30 \
#     JWT_RESET_PASSWORD_EXPIRATION_MINUTES=10 \
#     JWT_VERIFY_EMAIL_EXPIRATION_MINUTES=10 \
#     SMTP_HOST=smtp.ethereal.email \
#     SMTP_PORT=587 \
#     SMTP_USERNAME=allene.lindgren33@ethereal.email \
#     SMTP_PASSWORD=XpsMp5V7fyd14gDZpT \
#     EMAIL_FROM=allene.lindgren33@ethereal.email

# Switch to non-root user for security
USER node

# Install app dependencies
# If you are using npm, you can use npm ci for a faster, more reliable build
RUN if [ -f yarn.lock ]; then yarn install --frozen-lockfile; \
    else npm ci; fi

# Copy app source code with appropriate permissions
COPY --chown=node:node . .

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run your app
# This could be different based on how you start your application
CMD ["npm", "start"]
