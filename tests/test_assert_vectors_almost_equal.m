function test_suite=test_assert_vectors_almost_equal()
    try % assignment of "localfunctions" is necessary in Matlab >=2016a
        test_functions=localfunctions();
    catch % no problem; early Matlab versions can use initTestSuite fine
    end
    initTestSuite;

function test_assert_vectors_almost_equal_size_exceptions


    assertExceptionThrown(@()assertVectorsAlmostEqual(...
                                [1 2],[1;2]),...
                                'assertVectorsAlmostEqual:sizeMismatch');


function test_assert_vectors_almost_equal_tolerance_exceptions
    assertExceptionThrown(@()assertVectorsAlmostEqual(...
                                [1 2],[1 3]),...
                                'assertVectorsAlmostEqual:tolExceeded');
    assertExceptionThrown(@()assertVectorsAlmostEqual(...
                                0,1e-10,'absolute',1e-11),...
                                'assertVectorsAlmostEqual:tolExceeded');
    assertExceptionThrown(@()assertVectorsAlmostEqual(...
                                0,1e-24,'relative',0,0),...
                                'assertVectorsAlmostEqual:tolExceeded');
    assertExceptionThrown(@()assertVectorsAlmostEqual(...
                                NaN,NaN),...
                                'assertVectorsAlmostEqual:tolExceeded');
    assertExceptionThrown(@()assertVectorsAlmostEqual(...
                                -Inf,-Inf),...
                                'assertVectorsAlmostEqual:tolExceeded');


function test_assert_vectors_almost_equal_not_float_exception
    assertExceptionThrown(@()assertVectorsAlmostEqual(...
                                [1],'a'),...
                                'assertVectorsAlmostEqual:notFloat');
    assertExceptionThrown(@()assertVectorsAlmostEqual(...
                                'a',1),...
                                'assertVectorsAlmostEqual:notFloat');

    assertExceptionThrown(@()assertVectorsAlmostEqual(...
                                struct(),struct()),...
                                'assertVectorsAlmostEqual:notFloat');
    assertExceptionThrown(@()assertVectorsAlmostEqual(...
                                {1,'a'},{1,'a'}),...
                                'assertVectorsAlmostEqual:notFloat');


function test_assert_vectors_almost_equal_tol_type_exception
    assertExceptionThrown(@()assertVectorsAlmostEqual(...
                                1,1,'foo',1),...
                                'compareFloats:unrecognizedToleranceType');


function test_assert_vectors_almost_equal_not_vector_exception
    % note: xUnit does not throw an exception here
    assertExceptionThrown(@()assertVectorsAlmostEqual(...
                                [1 2;3 4],1e-10+[1 2; 3 4]),...
                                 'assertVectorsAlmostEqual:notVector');



function test_assert_vectors_almost_equal_passes
    assertVectorsAlmostEqual(0,0);

    a=randn();
    assertVectorsAlmostEqual(a,a);

    assertVectorsAlmostEqual(0,1e-10);
    assertVectorsAlmostEqual(0,1,'relative',1);
    assertVectorsAlmostEqual(0,1,'absolute',1);
    assertVectorsAlmostEqual(1:6,1e-10+(1:6))
    assertVectorsAlmostEqual(1:6,sparse(1e-10+(1:6)))

