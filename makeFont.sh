#!/bin/sh

#Chinese MainLand
makeChineseOtf() {
	for line in `find . -type d | grep -vE '\\\.|\.git|OTC'`
	do
		echo "make $line"
		cd $line
		makeotf -f cidfont.ps.CN -ff features.CN -fi cidfontinfo.CN -mf ../FontMenuNameDB.SUBSET -r -nS -cs 25 -ch ../UniSourceHanSansCN-UTF32-H
		cd -
	done
}

makeChineseHwOtf() {
	for line in `find . -type d | grep OTC`
	do
		echo "make $line"
		cd $line
		makeotf -f cidfont.ps.OTC.TC -ff features.OTC.TC -fi cidfontinfo.OTC.TC -mf ../../FontMenuNameDB -r -nS -cs 2 -ch ../../UniSourceHanSansTW-UTF32-H -ci ../../SourceHanSans_TWHK_sequences.txt
		cd -
	done
}
makeChineseSpecificOtf() {
	for line in `find . -type d | grep OTC`
	do
		echo "make $line"
		cd $line
		makeotf -f cidfont.ps.OTC.SC -ff features.OTC.SC -fi cidfontinfo.OTC.SC -mf ../../FontMenuNameDB -r -nS -cs 25 -ch ../../UniSourceHanSansCN-UTF32-H
		cd -
	done
}

makeOtf2Otc() {
for line in `find . -type d | grep OTC`
	do
		echo "make $line"
		cd $line
		otf2otc -t 'CFF '=0 -o SourceHanSans-$dir.ttc SourceHanSans-$dir.otf SourceHanSansK-$dir.otf SourceHanSansSC-$dir.otf SourceHanSansTC-$dir.otf
		cd -
	done
}


#Chinese TW

makeChineseTwOtf() {
	for line in `find . -type d | grep -vE "\\\.|\.git|OTC"`
	do
		echo "make $line"
		cd $line
		makeotf -f cidfont.ps.TW -ff features.TW -fi cidfontinfo.TW -mf ../FontMenuNameDB.SUBSET -r -nS -cs 2 -ch ../UniSourceHanSansTW-UTF32-H -ci ../SourceHanSans_TWHK_sequences.txt
		cd -
	done
}



makeChineseSpecificTwOtf() {
	for line in `find . -type d | grep OTC`
	do
		echo "make $line"
		cd $line
		makeotf -f cidfont.ps.OTC.TC -ff features.OTC.TC -fi cidfontinfo.OTC.TC -mf ../../FontMenuNameDB -r -nS -cs 2 -ch ../../UniSourceHanSansTW-UTF32-H -ci ../../SourceHanSans_TWHK_sequences.txt
		cd -
	done
}

copyToReleaseDir() {
	mkdir RELEASE
	for line in `find . -type f -name *.otf`
	do
		echo "copy $line ..."
		echo `dirname $line | cut -d/ -f2`
		echo `basename $line`
		mkdir RELEASE/`dirname $line | cut -d/ -f2`
		cp $line RELEASE/`dirname $line`
	done
}


cleanLastResult() {
	rm -rf `git status -s | cut -d\  -f2`
}
#makeChineseOtf
cleanLastResult
makeChineseSpecificOtf
copyToReleaseDir
