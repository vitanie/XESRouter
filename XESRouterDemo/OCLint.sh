#!/bin/sh
#workspace扩展名
workspaceExt=".xcworkspace"
tempPath=""
#获取当前路径
project_path=$(pwd)
#拿到Project的名字
project_name=$(ls | grep xcodeproj | awk -F.xcodeproj '{print $1}')

#是否使用第三方 pod管理
if [ -f Podfile ];then
echo "pod update"
#pod update
fi

#找到workspace文件
for workspacePath in `find ${project_path} -name "$project_name$workspaceExt" -print`
do
tempPath=${workspacePath}
break
done
echo "workspace路径为:" ${tempPath}

#OCLint
echo "============OCLint================"
if [ "$tempPath" == "" ];then
# oclint clean
xcodebuild -project ${project_name}.xcodeproj \
-scheme ${project_name} \
clean
echo "===========oclint=project=clean=done========="
# build
xcodebuild -project ${project_name}.xcodeproj \
-scheme ${project_name} \
| xcpretty -r json-compilation-database -o compile_commands.json
-reporter json-compilation-database:compile_commands.json \

build
echo "===========oclint=project=build=done========="
else
# oclint clean
xcodebuild -workspace ${project_name}.xcworkspace \
-scheme ${project_name} \
clean
echo "===========oclint=workspace=clean=done========="
# build
xcodebuild -workspace ${project_name}.xcworkspace \
-scheme ${project_name} \
-configuration Debug \
| xcpretty -r json-compilation-database -o compile_commands.json
-reporter json-compilation-database:compile_commands.json \
analyze
echo "===========oclint=workspace=build=done========="
fi

# 生成报表
oclint-json-compilation-database -v \
-e Pods \
oclint_args -- -report-type html -o oclintReport.html \
-disable-rule ObjCAssignIvarOutsideAccessors \
-rc=MINIMUM_CASES_IN_SWITCH=3 \
-rc=LONG_VARIABLE_NAME=20 \
-disable-rule ShortVariableName \
-rc=CYCLOMATIC_COMPLEXITY=10 \
-rc=LONG_CLASS=700 \
-rc=LONG_LINE=200 \
-rc=LONG_METHOD=80 \
-rc=NCSS_METHOD=40 \
-rc=NESTED_BLOCK_DEPTH=5 \
-rc=TOO_MANY_FIELDS=20 \
-rc=TOO_MANY_METHODS=30 \
-rc=TOO_MANY_PARAMETERS=6

# 删除 compile_commands.json 可能会很大
jsonPath=$project_path/"compile_commands.json"
#echo ${jsonPath}
rm $jsonPath
open oclintReport.html
exit

