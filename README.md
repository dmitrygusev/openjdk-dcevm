# openjdk-dcevm

## Build

0. Optionally change target JDK (`FROM openjdk:8-jdk`) and DCEVM version (`$DCEVM_TAG`) in `Dockerfile` to get desired version of DCEVM binaries compatible with your target docker image.

1. Build docker image with DCEVM binaries:

   ```bash
docker build -t openjdk-dcevm:8-jdk .
```

2. Extract DCEVM binaries by running `./extract-dcevm-from-image.bash`

3. DCEVM binaries will be copied to `./dcevm` directory

4. Upload DCEMV binaries to Maven repository: `./gradlew publishToMavenLocal`

## Use

1. Add DCEVM binaries as regular Maven dependencies

2. Copy them during the build to some temporary folder, i.e.:

   ```
configurations { dcevmLibs }

dependencies {
    def dcevm_version = 'light-jdk8u92+1'
    dcevmLibs group: 'dmitrygusev', name: 'openjdk-dcevm', version: dcevm_version, classifier: 'libjvm', ext: 'so'
    dcevmLibs group: 'dmitrygusev', name: 'openjdk-dcevm', version: dcevm_version, classifier: 'libjsig', ext: 'so'
}

task copyDcevmLibs(type: Copy) {
    into "${project.buildDir}/dcevm"
    from configurations.dcevmLibs
}
```

2. Copy them with 'ADD' or 'COPY' instructions in your Dockerfile to your target docker image, i.e.:

   ```dockerfile
ADD build/dcemv/*libjvm* /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/dcevm/libjvm.so
ADD build/dcemv/*libjsig* /usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/dcevm/libjsig.so
```

3. Add -XXaltjvm=dcevm to the `JVM_OPTS` to work with DCEVM runtime
