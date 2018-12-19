#EXAMPLE OF MULTI-STEP BUILD

# #####################################
# STEP 1 -- build phase
# #####################################

# Use an existing docker image as a base. 
# The "as <value>" indicates the step
FROM node:alpine as builder 

# Change the working directory for following commands
WORKDIR /usr/app

# Copy the files into the container & Download and install all npm dependencies
COPY ./package.json .
RUN npm install

COPY . .

# build now based upon the copied files
RUN npm run build


# #####################################
# STEP 2 -- run phase
# #####################################

# The "FROM" statement ends the 1st phase
FROM nginx

# Instruction for AWS Elastic BeansTalk
EXPOSE 80

# Copy from the 1st phase
COPY --from=builder /usr/app/build /usr/share/nginx/html
