
#Clone the fresh contrail-installer repository from the git by using command below#
git clone http://github.com/shravani89/contrail-installer -b test-m1-build

cd contrail-installer 

#Copy the file localrc-all from samples directory to the current directory as localrc and make sure that localrc file have the following changes#
cp samples/localrc-all localrc

#To disable the binary installation and download,If binaries need to be downloaded and installed make above “True”#
sed -i 's/# CONTRAIL_DEFAULT_INSTALL=True/CONTRAIL_DEFAULT_INSTALL=False/g' localrc

#Branch that points to the changes made in scons directory#
sed -i 's/# CONTRAIL_BRANCH=test-m1-build/CONTRAIL_BRANCH=test-m1-build/g' localrc

#repo proto is https or (default) ssh. Leave commented for ssh
sed -i 's/# CONTRAIL_REPO_PROTO=https/CONTRAIL_REPO_PROTO=https/g' localrc

#To install profile#
echo " 1. want to install only compute \n 2. want to install all "
read b
if [ $b -eq 1 ]
then
	echo " INSTALL_PROFILE=COMPUTE " >> localrc
elif [ $b -eq 2 ]
then
	echo " INSTALL_PROFILE=ALL " >> localrc
else
	echo " invalid option "
fi

#To use screens#
echo " 1. want screens "
read a
if [ $a -eq 1 ]
then
        echo " USE_SCREEN=TRUE " >> localrc
else
        echo " invalid option "
fi

#cd contrail-installer
#Build the contrail with all the required packages using the command#
./contrail.sh build

#To install contrail modules and its dependencies#
./contrail.sh install

#Configure the contrail using#
./contrail.sh configure

#Start the contrail services using the command#
./contrail.sh start

#To stop the contrail services at any time use#
#./contrail.sh stop

#Clean is enabled in this version so that we can run clean using#
#./contrail.sh clean
