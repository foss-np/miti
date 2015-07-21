var should = require('chai').should(),
    adbsconverter = require('../../src/converter.js'),
    bs2ad = adbsconverter.bs2ad,
    ad2bs = adbsconverter.ad2bs;

describe('#bs2ad', function() {
    it('Converts 2072/4/3 to 2015/7/19', function() {
        bs2ad('2072/4/3').should.equal('2015/7/19');
    });

    it('Converts 2072/4/16 to 2015/8/1', function() {
        bs2ad('2072/4/16').should.equal('2015/8/1');
    });

    it('Converts 2070/9/17 to 2014/1/1', function() {
        bs2ad('2070/9/17').should.equal('2014/1/1');
    });
});

describe('#ad2bs', function() {
    it('Converts 2015/8/1 to 2072/4/16', function() {
        ad2bs('2015/8/1').should.equal('2072/4/16');
    });

    it('Converts 2014/1/1 to 2070/9/17', function() {
        ad2bs('2014/1/1').should.equal('2070/9/17');
    });

    it('Converts 2015/7/19 to 2072/4/3', function() {
        ad2bs('2015/7/19').should.equal('2072/4/3');
    });
});

// below needs some changes
//describe('#ad2bs get day of week', function() {
//   it('Converts 2015/8/1 to Saturday', function() {
//       getWeek(ad2bs('2015/8/1'), 'ne').should.equal('Saturday')
//   });
//});
//
//describe('#bs2ad get day of week', function() {
//    it('Converts 2015/8/1 to Saturday', function() {
//        getWeek(ad2bs('2072/4/16'), 'en').should.equal('Saturday')
//    });
//});
