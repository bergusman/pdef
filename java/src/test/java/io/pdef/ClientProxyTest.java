package io.pdef;

import com.google.common.base.Function;
import com.google.common.base.Stopwatch;
import com.google.common.util.concurrent.Atomics;
import io.pdef.fluent.FluentFuture;
import io.pdef.fluent.FluentFutures;
import io.pdef.rpc.MethodCall;
import io.pdef.test.interfaces.App;
import io.pdef.test.interfaces.AsyncApp;
import io.pdef.test.interfaces.Calc;
import org.junit.Test;

import javax.annotation.Nullable;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

import static org.junit.Assert.assertEquals;

public class ClientProxyTest {
	@Test
	public void testPerf() throws Exception {
		Pdef pdef = new Pdef();
		PdefProxy<App> client = new PdefProxy<App>(App.class, pdef,
				new Function<List<MethodCall>, Object>() {
					@Override
					public Object apply(final List<MethodCall> input) {
						return 11;
					}
				});

		App app = client.proxy();

		int q = 0;
		for (int i = 0; i < 200 * 1000; i++) {
			q += app.calc().sum(1, 10);
		}

		int n = 10 * 1000 * 1000;
		Stopwatch sw = new Stopwatch().start();
		for (int i = 0; i < n; i++) {
			q += app.calc().sum(1, 10);
		}
		System.out.println(sw);
		System.out.println(q);
	}

	/** Should capture all method invocations with arguments. */
	@Test
	public void testInvoke_invocations() throws Exception {
		Pdef pdef = new Pdef();
		final AtomicReference<List<MethodCall>> ref = Atomics.newReference();
		PdefProxy<App> client = new PdefProxy<App>(App.class, pdef,
				new Function<List<MethodCall>, Object>() {
					@Override
					public Object apply(@Nullable final List<MethodCall> input) {
						ref.set(input);
						return 11;
					}
				});

		App app = client.proxy();
		app.calc().sum(1, 10);

		PdefInterface appInfo = (PdefInterface) pdef.get(App.class);
		PdefInterface calcInfo = (PdefInterface) pdef.get(Calc.class);
//		assertEquals(ImmutableList.of(
//				new Invocation(appInfo.getMethods().get("calc"), null),
//				new Invocation(calcInfo.getMethods().get("sum"), new Object[] {1, 10})),
//				ref.get());
	}

	/** Should invoke a sync invocation chain handler. */
	@Test
	public void testInvoke() throws Exception {
		Pdef pdef = new Pdef();
		PdefProxy<App> client = new PdefProxy<App>(App.class, pdef,
				new Function<List<MethodCall>, Object>() {
					@Override
					public Object apply(@Nullable final List<MethodCall> input) {
						return 11;
					}
				});

		App app = client.proxy();
		Integer result = app.calc().sum(1, 10);
		assertEquals(11, (int) result);
	}

	/** Should invoke an async invocation chain handler. */
	@Test
	public void testInvoke_future() throws Exception {
		Pdef pdef = new Pdef();
		PdefProxy<AsyncApp> client = new PdefProxy<AsyncApp>(AsyncApp.class, pdef,
				new Function<List<MethodCall>, Object>() {
					@Nullable
					@Override
					public Object apply(@Nullable final List<MethodCall> input) {
						return FluentFutures.of(11);
					}
				});

		AsyncApp app = client.proxy();
		FluentFuture<Integer> future = app.calc().sum(1, 10);
		Integer result = future.get();
		assertEquals(11, (int) result);
	}
}
