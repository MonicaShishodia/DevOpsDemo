using System;
using NUnit.Framework;
using DevOpsDemo;

namespace DevOpsDemo.Test
{
    [TestFixture]
    public class UnitTest1
    {
        [TestCase]
       // [Category("Fail")]
        public void TestInputPath()
        {
            Program obj = new Program();
           Assert.AreEqual(obj.getFiles(TestContext.Parameters["Path"]),true);
        }
    }
}
